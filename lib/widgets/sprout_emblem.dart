import 'package:flutter/material.dart';

class SproutEmblem extends StatelessWidget {
  final double size;

  const SproutEmblem({super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft ambient glow behind the sprout
          Container(
            width: size * 0.9,
            height: size * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF38BDF8).withValues(alpha: 0.35),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/sprout_emblem.png',
            width: size,
            height: size,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => CustomPaint(
              size: Size(size, size),
              painter: _SproutPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SproutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 1. Center upper teardrop petal
    final Path centerLeaf = Path();
    centerLeaf.moveTo(w * 0.5, h * 0.08);
    centerLeaf.cubicTo(
      w * 0.65,
      h * 0.22,
      w * 0.68,
      h * 0.36,
      w * 0.5,
      h * 0.52,
    );
    centerLeaf.cubicTo(
      w * 0.32,
      h * 0.36,
      w * 0.35,
      h * 0.22,
      w * 0.5,
      h * 0.08,
    );
    centerLeaf.close();
    canvas.drawPath(centerLeaf, paint);

    // 2. Lower crescent / cup
    final Path crescent = Path();
    crescent.moveTo(w * 0.5, h * 0.65);
    // Inner contour curving up-left to left tip
    crescent.cubicTo(
      w * 0.32,
      h * 0.56,
      w * 0.16,
      h * 0.46,
      w * 0.04,
      h * 0.42,
    );
    // Outer contour curving down to bottom bowl
    crescent.cubicTo(
      w * 0.12,
      h * 0.70,
      w * 0.30,
      h * 0.94,
      w * 0.5,
      h * 0.94,
    );
    // Outer contour curving up to right tip
    crescent.cubicTo(
      w * 0.70,
      h * 0.94,
      w * 0.88,
      h * 0.70,
      w * 0.96,
      h * 0.42,
    );
    // Inner contour curving down-left to inner notch
    crescent.cubicTo(
      w * 0.84,
      h * 0.46,
      w * 0.68,
      h * 0.56,
      w * 0.5,
      h * 0.65,
    );
    crescent.close();
    canvas.drawPath(crescent, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

