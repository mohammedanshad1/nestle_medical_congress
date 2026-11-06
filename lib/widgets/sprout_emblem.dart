import 'package:flutter/material.dart';

class SproutEmblem extends StatelessWidget {
  final double size;

  const SproutEmblem({super.key, this.size = 56});

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
          CustomPaint(
            size: Size(size, size),
            painter: _SproutPainter(),
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

    // 1. Center upper leaf / drop
    final Path centerLeaf = Path();
    centerLeaf.moveTo(w * 0.5, h * 0.16);
    centerLeaf.cubicTo(
      w * 0.58,
      h * 0.28,
      w * 0.58,
      h * 0.40,
      w * 0.5,
      h * 0.48,
    );
    centerLeaf.cubicTo(
      w * 0.42,
      h * 0.40,
      w * 0.42,
      h * 0.28,
      w * 0.5,
      h * 0.16,
    );
    centerLeaf.close();
    canvas.drawPath(centerLeaf, paint);

    // 2. Left curved leaf
    final Path leftLeaf = Path();
    leftLeaf.moveTo(w * 0.45, h * 0.56);
    leftLeaf.cubicTo(
      w * 0.22,
      h * 0.52,
      w * 0.12,
      h * 0.38,
      w * 0.16,
      h * 0.30,
    );
    leftLeaf.cubicTo(
      w * 0.30,
      h * 0.32,
      w * 0.42,
      h * 0.42,
      w * 0.45,
      h * 0.56,
    );
    leftLeaf.close();
    canvas.drawPath(leftLeaf, paint);

    // 3. Right curved leaf
    final Path rightLeaf = Path();
    rightLeaf.moveTo(w * 0.55, h * 0.56);
    rightLeaf.cubicTo(
      w * 0.78,
      h * 0.52,
      w * 0.88,
      h * 0.38,
      w * 0.84,
      h * 0.30,
    );
    rightLeaf.cubicTo(
      w * 0.70,
      h * 0.32,
      w * 0.58,
      h * 0.42,
      w * 0.55,
      h * 0.56,
    );
    rightLeaf.close();
    canvas.drawPath(rightLeaf, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

