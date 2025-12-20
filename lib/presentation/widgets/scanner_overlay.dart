import 'package:flutter/material.dart';
import '../../core/theme/retain_learn_theme.dart';

class ScannerOverlay extends StatefulWidget {
  final Widget child;
  final bool isScanning;
  final VoidCallback? onScanComplete;

  const ScannerOverlay({
    super.key,
    required this.child,
    this.isScanning = true,
    this.onScanComplete,
  });

  @override
  State<ScannerOverlay> createState() => _ScannerOverlayState();
}

class _ScannerOverlayState extends State<ScannerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base content (Camera/Image)
        widget.child,

        // Dimmed Overlay with Cutout
        CustomPaint(
          painter: _OverlayPainter(),
          child: Container(),
        ),

        // Corner Brackets
        const Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: _CornerBrackets(),
          ),
        ),

        // Laser Scan Line
        if (widget.isScanning)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                top: 100 + (_animation.value * (MediaQuery.of(context).size.height * 0.5)),
                left: 40,
                right: 40,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        RetainLearnTheme.tealPrimary.withOpacity(0),
                        RetainLearnTheme.tealLight,
                        RetainLearnTheme.tealPrimary.withOpacity(0),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: RetainLearnTheme.tealPrimary.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
        // White Flash on Complete (Simulated via overlay)
        // Note: For a real flash, we'd toggle a white container's opacity.
      ],
    );
  }
}

class _OverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.5);
    
    // Define scan area (center)
    final scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width - 80,
      height: size.height * 0.6,
    );

    // Draw background with hole
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(16))),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CornerBrackets extends StatelessWidget {
  const _CornerBrackets();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BracketPainter(),
    );
  }
}

class _BracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final double cornerSize = 30;

    // Top Left
    canvas.drawPath(
      Path()
        ..moveTo(0, cornerSize)
        ..lineTo(0, 0)
        ..lineTo(cornerSize, 0),
      paint,
    );
    // Top Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerSize, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, cornerSize),
      paint,
    );
    // Bottom Left
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - cornerSize)
        ..lineTo(0, size.height)
        ..lineTo(cornerSize, size.height),
      paint,
    );
    // Bottom Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerSize, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height - cornerSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
