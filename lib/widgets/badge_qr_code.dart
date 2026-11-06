import 'package:flutter/material.dart';

class BadgeQrCode extends StatelessWidget {
  final double size;
  final Color color;

  const BadgeQrCode({
    super.key,
    this.size = 110,
    this.color = const Color(0xFF0C1D36),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 24,
      height: size + 24,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.1,
        ),
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: _QrCodePainter(color: color),
      ),
    );
  }
}

class _QrCodePainter extends CustomPainter {
  final Color color;

  _QrCodePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw the 3 position finder patterns (Top-Left, Top-Right, Bottom-Left)
    final double cornerSize = w * 0.32;
    final double innerCornerSize = cornerSize * 0.55;

    // 1. Top-Left Finder
    _drawFinderPattern(canvas, const Offset(0, 0), cornerSize, innerCornerSize, fillPaint);

    // 2. Top-Right Finder
    _drawFinderPattern(canvas, Offset(w - cornerSize, 0), cornerSize, innerCornerSize, fillPaint);

    // 3. Bottom-Left Finder
    _drawFinderPattern(canvas, Offset(0, h - cornerSize), cornerSize, innerCornerSize, fillPaint);

    // Data modules grid
    const int gridCount = 9;
    final double cellSize = w / gridCount;

    // Custom pattern of blocks representing "NMC-2026-001"
    const List<List<int>> matrix = [
      [0, 0, 0, 1, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 1, 0, 0, 0],
      [1, 0, 1, 0, 1, 0, 1, 1, 1],
      [0, 1, 1, 1, 0, 1, 0, 1, 0],
      [1, 0, 1, 0, 1, 1, 1, 0, 1],
      [0, 0, 0, 1, 0, 1, 0, 1, 0],
      [0, 0, 0, 0, 1, 0, 1, 0, 1],
      [0, 0, 0, 1, 1, 0, 0, 1, 1],
    ];

    for (int r = 0; r < gridCount; r++) {
      for (int c = 0; c < gridCount; c++) {
        // Skip corner finder areas
        if (r < 3 && c < 3) continue;
        if (r < 3 && c >= 6) continue;
        if (r >= 6 && c < 3) continue;

        if (matrix[r][c] == 1) {
          final RRect cellRRect = RRect.fromRectAndRadius(
            Rect.fromLTWH(
              c * cellSize + cellSize * 0.08,
              r * cellSize + cellSize * 0.08,
              cellSize * 0.84,
              cellSize * 0.84,
            ),
            Radius.circular(cellSize * 0.2),
          );
          canvas.drawRRect(cellRRect, fillPaint);
        }
      }
    }
  }

  void _drawFinderPattern(
    Canvas canvas,
    Offset offset,
    double outerSize,
    double innerSize,
    Paint paint,
  ) {
    final Paint strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerSize * 0.18;

    // Outer ring
    final double halfStroke = strokePaint.strokeWidth / 2;
    final RRect outerBox = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx + halfStroke,
        offset.dy + halfStroke,
        outerSize - strokePaint.strokeWidth,
        outerSize - strokePaint.strokeWidth,
      ),
      Radius.circular(outerSize * 0.22),
    );
    canvas.drawRRect(outerBox, strokePaint);

    // Inner filled box
    final double innerOffset = (outerSize - innerSize) / 2;
    final RRect innerBox = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx + innerOffset,
        offset.dy + innerOffset,
        innerSize,
        innerSize,
      ),
      Radius.circular(innerSize * 0.25),
    );
    canvas.drawRRect(innerBox, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

