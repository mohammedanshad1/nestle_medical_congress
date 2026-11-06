import 'package:flutter/material.dart';

class MedicalShieldBadge extends StatelessWidget {
  final double size;

  const MedicalShieldBadge({super.key, this.size = 52});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2B8CFF),
            Color(0xFF0D63E5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D63E5).withValues(alpha: 0.38),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: SizedBox(
          width: size * 0.58,
          height: size * 0.62,
          child: CustomPaint(
            painter: _ShieldCrossPainter(),
          ),
        ),
      ),
    );
  }
}

class _ShieldCrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Draw the white shield
    final Path shieldPath = Path();
    shieldPath.moveTo(w * 0.5, 0);
    shieldPath.quadraticBezierTo(w * 0.95, 0, w, h * 0.28);
    shieldPath.quadraticBezierTo(w, h * 0.68, w * 0.5, h);
    shieldPath.quadraticBezierTo(0, h * 0.68, 0, h * 0.28);
    shieldPath.quadraticBezierTo(w * 0.05, 0, w * 0.5, 0);
    shieldPath.close();

    final Paint shieldPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawPath(shieldPath, shieldPaint);

    // Draw the blue medical cross (+) in the center of the shield
    final Paint crossPaint = Paint()
      ..color = const Color(0xFF0D63E5)
      ..style = PaintingStyle.fill;

    final double cx = w * 0.5;
    final double cy = h * 0.46;
    final double armThickness = w * 0.16;
    final double armLength = w * 0.44;
    final double radius = armThickness * 0.35;

    // Horizontal arm of cross
    final RRect hArm = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: armLength,
        height: armThickness,
      ),
      Radius.circular(radius),
    );

    // Vertical arm of cross
    final RRect vArm = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: armThickness,
        height: armLength,
      ),
      Radius.circular(radius),
    );

    canvas.drawRRect(hArm, crossPaint);
    canvas.drawRRect(vArm, crossPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
