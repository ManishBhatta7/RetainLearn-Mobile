# RetainLearn Flutter

A Flutter mobile application for the RetainLearn platform - an AI-powered educational platform for personalized learning.

## 🏗️ Architecture

This project follows **Clean Architecture** with the **Repository Pattern** to ensure:
- Complete decoupling of UI from data sources
- Easy migration from Supabase to a custom Node.js backend
- Testability and maintainability

### Project Structure

```
lib/
├── main.dart                          # App entry point
│
├── core/                              # Core utilities and configuration
│   ├── constants/
│   │   └── app_constants.dart         # App-wide constants
│   ├── router/
│   │   └── app_router.dart            # GoRouter configuration
│   └── theme/
│       ├── app_theme.dart             # Material 3 theme
│       └── app_colors.dart            # Color palette
│
├── domain/                            # Domain Layer (Business Logic)
│   ├── models/                        # Data models (freezed)
│   │   ├── assignment.dart
│   │   ├── user.dart
│   │   ├── classroom.dart
│   │   └── models.dart                # Barrel export
│   └── repositories/                  # Abstract repository interfaces
│       ├── assignment_repository.dart # ⭐ KEY: Abstract interface
│       ├── auth_repository.dart
│       ├── classroom_repository.dart
│       └── repositories.dart          # Barrel export
│
├── data/                              # Data Layer (Implementation)
│   ├── repositories/                  # Concrete implementations
│   │   ├── supabase_assignment_repository.dart  # Current: Supabase
│   │   └── supabase_auth_repository.dart
│   ├── providers/
│   │   └── repository_providers.dart  # ⭐ Riverpod DI configuration
│   └── services/                      # Native feature services
│       ├── voice_recorder_service.dart # Speech-to-Text
│       ├── ocr_scanner_service.dart    # ML Kit OCR
│       └── tts_service.dart            # Text-to-Speech
│
└── presentation/                      # Presentation Layer (UI)
    ├── pages/                         # Screen widgets
    │   ├── dashboard_page.dart
    │   ├── assignments_page.dart      # ⭐ Uses repository via Riverpod
    │   ├── ocr_scanner_page.dart
    │   ├── voice_reading_page.dart
    │   └── ...
    └── widgets/                       # Reusable widgets
        └── main_scaffold.dart         # Bottom navigation
```

## 🎯 Key Design Decisions

### Repository Pattern

The UI layer **NEVER** imports Supabase directly. Instead:

```dart
// ❌ BAD - UI depends on Supabase
import 'package:supabase_flutter/supabase_flutter.dart';
await Supabase.instance.client.from('assignments').select();

// ✅ GOOD - UI depends on abstract repository
final assignments = await ref.read(assignmentRepositoryProvider).getAssignments();
```

### State Management (Riverpod)

All repositories are provided via Riverpod:

```dart
// Provides abstract interface
final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  return SupabaseAssignmentRepository(ref.read(supabaseProvider));
});

// Consume in widgets
class AssignmentsPage extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(assignmentsNotifierProvider);
    // UI has NO knowledge of Supabase!
  }
}
```

## 🔄 Backend Migration Guide

To migrate from Supabase to a custom Node.js backend:

### Step 1: Create New Repository Implementation

```dart
// lib/data/repositories/http_assignment_repository.dart
class HttpAssignmentRepository implements AssignmentRepository {
  final HttpClient _client;
  
  HttpAssignmentRepository(this._client);

  @override
  Future<List<Assignment>> getAssignments() async {
    final response = await _client.get('/api/assignments');
    return response.data.map((j) => Assignment.fromJson(j)).toList();
  }
  // ... implement all other methods
}
```

### Step 2: Update Provider

```dart
// lib/data/providers/repository_providers.dart

// BEFORE (Supabase):
final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  return SupabaseAssignmentRepository(ref.read(supabaseProvider));
});

// AFTER (Custom Backend):
final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  return HttpAssignmentRepository(ref.read(httpClientProvider));
});
```

### Step 3: Done!

The UI layer requires **ZERO changes** because it only depends on the abstract `AssignmentRepository` interface.

## 📱 Native Features

### Voice Recording (Speech-to-Text)
```dart
final voiceService = ref.read(voiceRecorderServiceProvider);
await voiceService.startListening(onResult: (text) => print(text));
```

### OCR Scanner (ML Kit)
```dart
final ocrService = ref.read(ocrScannerServiceProvider);
final result = await ocrService.scanFromCamera();
print(result?.text);
```

### Text-to-Speech
```dart
final tts = ref.read(ttsServiceProvider);
await tts.speak('Hello, student!');
```

## 🛠️ Setup

### Prerequisites
- Flutter SDK (3.2.0 or higher)
- Android Studio / VS Code
- Android device or emulator

### Installation

```bash
cd adaptive_ed_coach_flutter

# Get dependencies
flutter pub get

# Generate freezed models
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Required Permissions (Android)

The app requires the following permissions (already configured in AndroidManifest.xml):
- `RECORD_AUDIO` - Voice recording
- `CAMERA` - OCR scanning
- `INTERNET` - Supabase connectivity

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State management |
| `go_router` | Navigation |
| `supabase_flutter` | Backend (wrapped in repositories) |
| `hive_flutter` | Local storage |
| `google_mlkit_text_recognition` | OCR |
| `speech_to_text` | Voice input |
| `flutter_tts` | Voice output |
| `fl_chart` | Charts |
| `freezed` | Immutable models |
| `permission_handler` | Permission management |

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📝 License

MIT License - See LICENSE file for details.
