import 'package:flutter/material.dart';

class AppleLogo extends StatelessWidget {
  final double size;
  final Color color;
  final String? imageUrl;

  const AppleLogo({
    super.key,
    this.size = 24,
    this.color = Colors.black,
    this.imageUrl,
  });

  /// High-resolution monochrome Apple icon CDN
  static const String defaultUrl =
      'https://cdn-icons-png.flaticon.com/512/0/747.png';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.network(
        imageUrl ?? defaultUrl,
        width: size,
        height: size,
        color: color,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildVectorFallback();
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildVectorFallback();
        },
      ),
    );
  }

  Widget _buildVectorFallback() {
    return Icon(
      Icons.apple,
      color: color,
      size: size,
    );
  }
}

