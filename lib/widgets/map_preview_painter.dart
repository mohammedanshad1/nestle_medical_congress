import 'package:flutter/material.dart';

class MapPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // 1. Soft map background
    final Paint bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE2F1FC),
          Color(0xFFEBF7FF),
          Color(0xFFD9ECFB),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final RRect mapRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(26),
    );
    canvas.drawRRect(mapRRect, bgPaint);

    // Clip to rounded container
    canvas.save();
    canvas.clipRRect(mapRRect);

    // 2. Map road/route vector lines
    final Paint roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    final Paint minorRoadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Curved primary road 1
    final Path road1 = Path();
    road1.moveTo(0, h * 0.65);
    road1.cubicTo(w * 0.35, h * 0.60, w * 0.60, h * 0.35, w * 0.75, 0);
    canvas.drawPath(road1, roadPaint);

    // Curved primary road 2
    final Path road2 = Path();
    road2.moveTo(w * 0.25, h);
    road2.cubicTo(w * 0.38, h * 0.55, w * 0.65, h * 0.50, w, h * 0.58);
    canvas.drawPath(road2, roadPaint);

    // Curved intersecting route 3
    final Path road3 = Path();
    road3.moveTo(0, h * 0.25);
    road3.cubicTo(w * 0.45, h * 0.35, w * 0.55, h * 0.75, w * 0.85, h);
    canvas.drawPath(road3, minorRoadPaint);

    // Circular route ring around the center
    final Paint ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawCircle(Offset(w * 0.5, h * 0.56), w * 0.36, ringPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

