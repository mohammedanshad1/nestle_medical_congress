import 'package:flutter/material.dart';

class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Ambient blue glow in the upper right
    final Paint glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.85, -0.75),
        radius: 0.9,
        colors: [
          const Color(0xFF1D5CC9).withValues(alpha: 0.38),
          const Color(0xFF14418E).withValues(alpha: 0.18),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), glowPaint);

    // 2. Decorative dot matrix grid in the upper left
    final Paint dotPaint = Paint()
      ..color = const Color(0xFF60A5FA).withValues(alpha: 0.28)
      ..style = PaintingStyle.fill;

    const int cols = 5;
    const int rows = 6;
    const double startX = 20.0;
    const double startY = 32.0;
    const double spacing = 13.0;
    const double dotRadius = 1.6;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final double x = startX + c * spacing;
        final double y = startY + r * spacing;
        canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
      }
    }

    // 3. Subtle organic wave / contour lines
    final Paint linePaint1 = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Path wave1 = Path();
    wave1.moveTo(size.width * 0.4, 0);
    wave1.cubicTo(
      size.width * 0.7,
      size.height * 0.08,
      size.width * 0.95,
      size.height * 0.12,
      size.width,
      size.height * 0.15,
    );
    canvas.drawPath(wave1, linePaint1);

    final Paint linePaint2 = Paint()
      ..color = const Color(0xFF60A5FA).withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Path wave2 = Path();
    wave2.moveTo(size.width * 0.15, 0);
    wave2.cubicTo(
      size.width * 0.45,
      size.height * 0.12,
      size.width * 0.85,
      size.height * 0.16,
      size.width,
      size.height * 0.22,
    );
    canvas.drawPath(wave2, linePaint2);

    final Path wave3 = Path();
    wave3.moveTo(0, size.height * 0.18);
    wave3.cubicTo(
      size.width * 0.35,
      size.height * 0.22,
      size.width * 0.75,
      size.height * 0.25,
      size.width,
      size.height * 0.30,
    );
    canvas.drawPath(wave3, linePaint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
