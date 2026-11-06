import 'dart:math' as math;
import 'package:flutter/material.dart';

class GoogleLogo extends StatelessWidget {
  final double size;
  final String? imageUrl;

  const GoogleLogo({
    super.key,
    this.size = 22,
    this.imageUrl,
  });

  /// Official Google G brand logo from Google Identity CDN
  static const String defaultUrl =
      'https://developers.google.com/identity/images/g-logo.png';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.network(
        imageUrl ?? defaultUrl,
        width: size,
        height: size,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildFallback();
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback();
        },
      ),
    );
  }

  Widget _buildFallback() {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Offset center = Offset(w / 2, h / 2);
    final double radius = w / 2;
    final double innerRadius = radius * 0.58;
    final double strokeWidth = radius - innerRadius;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final Rect arcRect = Rect.fromCircle(
      center: center,
      radius: (radius + innerRadius) / 2,
    );

    // 1. Red (top quadrant)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(arcRect, -math.pi * 0.75, math.pi * 0.5, false, paint);

    // 2. Yellow (left quadrant)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(arcRect, -math.pi * 1.25, math.pi * 0.5, false, paint);

    // 3. Green (bottom quadrant)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(arcRect, math.pi * 0.25, math.pi * 0.5, false, paint);

    // 4. Blue (bottom right to center horizontal bar)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(arcRect, -math.pi * 0.25, math.pi * 0.45, false, paint);

    // Blue horizontal bar
    final Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF4285F4);

    final double barHeight = strokeWidth;
    final double barWidth = radius * 0.95;
    final Rect barRect = Rect.fromLTWH(
      center.dx,
      center.dy - barHeight / 2,
      barWidth,
      barHeight,
    );
    canvas.drawRect(barRect, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
