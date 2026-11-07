import 'package:flutter/material.dart';

class MapPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // 1. Clean pastel ice-blue map terrain background matching screen 8
    final Paint bgPaint = Paint()
      ..color = const Color(0xFFE5EEF9)
      ..style = PaintingStyle.fill;

    final RRect mapRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(28),
    );
    canvas.drawRRect(mapRRect, bgPaint);

    // Clip to rounded card corners
    canvas.save();
    canvas.clipRRect(mapRRect);

    // 2. Map road/route vector lines (Pure white smooth bezier curves)
    final Paint primaryRoadPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.5
      ..strokeCap = StrokeCap.round;

    final Paint minorRoadPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    // Primary horizontal road passing across the middle (under the pin)
    final Path mainRoad = Path();
    mainRoad.moveTo(0, h * 0.68);
    mainRoad.cubicTo(w * 0.35, h * 0.60, w * 0.65, h * 0.52, w, h * 0.58);
    canvas.drawPath(mainRoad, primaryRoadPaint);

    // Left prominent curved avenue (clearly visible to the right of the "Map Preview" pill)
    final Path leftAvenue = Path();
    leftAvenue.moveTo(w * 0.18, 0);
    leftAvenue.cubicTo(w * 0.28, h * 0.28, w * 0.32, h * 0.52, w * 0.28, h);
    canvas.drawPath(leftAvenue, minorRoadPaint);

    // Far left top corner curve
    final Path leftTopCorner = Path();
    leftTopCorner.moveTo(0, h * 0.12);
    leftTopCorner.cubicTo(w * 0.05, h * 0.06, w * 0.09, 0, w * 0.12, 0);
    canvas.drawPath(leftTopCorner, minorRoadPaint);

    // Right curved vertical bypass looping past the pin
    final Path rightRoad = Path();
    rightRoad.moveTo(w * 0.67, 0);
    rightRoad.cubicTo(w * 0.65, h * 0.38, w * 0.70, h * 0.75, w * 0.84, h);
    canvas.drawPath(rightRoad, minorRoadPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
