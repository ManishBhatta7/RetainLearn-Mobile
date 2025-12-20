import 'dart:io';
import 'dart:ui' show Rect;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// OCR Scanner Service
/// 
/// Wraps google_ml_kit_text_recognition to provide text extraction from images.
/// Equivalent to Tesseract.js on the web.
class OcrScannerService {
  final TextRecognizer _textRecognizer;
  final ImagePicker _imagePicker;

  OcrScannerService()
      : _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin),
        _imagePicker = ImagePicker();

  /// Request camera permission
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Scan text from an image file
  Future<OcrResult> scanImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      return OcrResult(
        text: recognizedText.text,
        blocks: recognizedText.blocks.map((block) {
          return OcrTextBlock(
            text: block.text,
            boundingBox: block.boundingBox,
            lines: block.lines.map((line) {
              return OcrTextLine(
                text: line.text,
                boundingBox: line.boundingBox,
              );
            }).toList(),
          );
        }).toList(),
      );
    } catch (e) {
      throw OcrException('Failed to process image: $e');
    }
  }

  /// Scan text from gallery image
  Future<OcrResult?> scanFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (pickedFile == null) return null;

      return scanImage(File(pickedFile.path));
    } catch (e) {
      throw OcrException('Failed to pick image from gallery: $e');
    }
  }

  /// Scan text from camera
  Future<OcrResult?> scanFromCamera() async {
    final hasPermission = await requestCameraPermission();
    if (!hasPermission) {
      throw OcrException(
        'Camera permission denied. Please enable it in settings.',
      );
    }

    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (pickedFile == null) return null;

      return scanImage(File(pickedFile.path));
    } catch (e) {
      throw OcrException('Failed to capture image: $e');
    }
  }

  /// Dispose of resources
  void dispose() {
    _textRecognizer.close();
  }
}

/// Result from OCR scanning
class OcrResult {
  final String text;
  final List<OcrTextBlock> blocks;

  OcrResult({
    required this.text,
    required this.blocks,
  });

  /// Whether any text was recognized
  bool get hasText => text.isNotEmpty;

  /// Number of text blocks recognized
  int get blockCount => blocks.length;
}

/// A block of text recognized by OCR
class OcrTextBlock {
  final String text;
  final Rect? boundingBox;
  final List<OcrTextLine> lines;

  OcrTextBlock({
    required this.text,
    this.boundingBox,
    required this.lines,
  });
}

/// A line of text within a block
class OcrTextLine {
  final String text;
  final Rect? boundingBox;

  OcrTextLine({
    required this.text,
    this.boundingBox,
  });
}

/// Custom exception for OCR errors
class OcrException implements Exception {
  final String message;

  OcrException(this.message);

  @override
  String toString() => 'OcrException: $message';
}

/// =============================================================================
/// RIVERPOD PROVIDERS
/// =============================================================================

/// Provider for OcrScannerService
final ocrScannerServiceProvider = Provider<OcrScannerService>((ref) {
  final service = OcrScannerService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Notifier for managing OCR scanning state
class OcrScanningNotifier extends StateNotifier<OcrScanningState> {
  final OcrScannerService _service;

  OcrScanningNotifier(this._service) : super(const OcrScanningState.initial());

  Future<void> scanFromCamera() async {
    state = const OcrScanningState.scanning();

    try {
      final result = await _service.scanFromCamera();
      if (result == null) {
        state = const OcrScanningState.initial();
      } else {
        state = OcrScanningState.completed(result);
      }
    } catch (e) {
      state = OcrScanningState.error(e.toString());
    }
  }

  Future<void> scanFromGallery() async {
    state = const OcrScanningState.scanning();

    try {
      final result = await _service.scanFromGallery();
      if (result == null) {
        state = const OcrScanningState.initial();
      } else {
        state = OcrScanningState.completed(result);
      }
    } catch (e) {
      state = OcrScanningState.error(e.toString());
    }
  }

  Future<void> scanImage(File file) async {
    state = const OcrScanningState.scanning();

    try {
      final result = await _service.scanImage(file);
      state = OcrScanningState.completed(result);
    } catch (e) {
      state = OcrScanningState.error(e.toString());
    }
  }

  void reset() {
    state = const OcrScanningState.initial();
  }
}

/// State for OCR scanning
class OcrScanningState {
  final OcrScanningStatus status;
  final OcrResult? result;
  final String? error;

  const OcrScanningState._({
    required this.status,
    this.result,
    this.error,
  });

  const OcrScanningState.initial()
      : this._(status: OcrScanningStatus.idle);

  const OcrScanningState.scanning()
      : this._(status: OcrScanningStatus.scanning);

  const OcrScanningState.completed(OcrResult ocrResult)
      : this._(status: OcrScanningStatus.completed, result: ocrResult);

  const OcrScanningState.error(String errorMessage)
      : this._(status: OcrScanningStatus.error, error: errorMessage);

  bool get isScanning => status == OcrScanningStatus.scanning;
  bool get hasError => status == OcrScanningStatus.error;
  bool get hasResult => status == OcrScanningStatus.completed && result != null;
}

enum OcrScanningStatus {
  idle,
  scanning,
  completed,
  error,
}

/// Provider for OcrScanningNotifier
final ocrScanningProvider =
    StateNotifierProvider<OcrScanningNotifier, OcrScanningState>((ref) {
  final service = ref.read(ocrScannerServiceProvider);
  return OcrScanningNotifier(service);
});
