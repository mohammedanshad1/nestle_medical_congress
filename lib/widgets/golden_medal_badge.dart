import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GoldenMedalBadge extends StatelessWidget {
  final double size;
  final Color? color;

  const GoldenMedalBadge({
    super.key,
    this.size = 22,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.25,
      child: Image.asset(
        'assets/images/golden_medal.png',
        width: size,
        height: size * 1.25,
        fit: BoxFit.contain,
        color: color,
        colorBlendMode: color != null ? BlendMode.srcIn : null,
        errorBuilder: (context, error, stackTrace) => CustomPaint(
          size: Size(size, size * 1.25),
          painter: _MedalPainter(color: color ?? AppColors.goldAccent),
        ),
      ),
    );
  }
}

class _MedalPainter extends CustomPainter {
  final Color color;

  _MedalPainter({this.color = AppColors.goldAccent});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint badgePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 1. Bottom Ribbon with triangular notch
    final Path ribbon = Path();
    ribbon.moveTo(w * 0.18, h * 0.45);
    ribbon.lineTo(w * 0.18, h * 0.95);
    ribbon.lineTo(w * 0.5, h * 0.82);
    ribbon.lineTo(w * 0.82, h * 0.95);
    ribbon.lineTo(w * 0.82, h * 0.45);
    ribbon.close();
    canvas.drawPath(ribbon, badgePaint);

    // 2. Outer Circle
    final double radius = w * 0.48;
    final Offset center = Offset(w * 0.5, radius);
    canvas.drawCircle(center, radius, badgePaint);

    // 3. Inner White Cutout
    final Paint whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.72, whitePaint);

    // 4. Center Star
    final Path star = Path();
    final double starRadius = radius * 0.44;
    final double innerStarRadius = starRadius * 0.45;
    for (int i = 0; i < 5; i++) {
      final double outerAngle = -math.pi / 2 + (i * 2 * math.pi / 5);
      final double innerAngle = outerAngle + math.pi / 5;
      final double xOuter = center.dx + starRadius * math.cos(outerAngle);
      final double yOuter = center.dy + starRadius * math.sin(outerAngle);
      final double xInner = center.dx + innerStarRadius * math.cos(innerAngle);
      final double yInner = center.dy + innerStarRadius * math.sin(innerAngle);
      if (i == 0) {
        star.moveTo(xOuter, yOuter);
      } else {
        star.lineTo(xOuter, yOuter);
      }
      star.lineTo(xInner, yInner);
    }
    star.close();
    canvas.drawPath(star, badgePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
