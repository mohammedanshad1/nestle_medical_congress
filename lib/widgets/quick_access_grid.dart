import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickAccessItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const QuickAccessItem({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class QuickAccessGrid extends StatelessWidget {
  final List<QuickAccessItem> items;

  const QuickAccessGrid({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Compute item width for a 4-column layout with 10px spacing
        const int crossAxisCount = 4;
        const double spacing = 10.0;
        final double totalSpacing = spacing * (crossAxisCount - 1);
        final double itemWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items.map((item) {
            return SizedBox(
              width: itemWidth,
              height: itemWidth * 1.02,
              child: _QuickAccessButton(item: item),
            );
          }).toList(),
        );
      },
    );
  }
}

class _QuickAccessButton extends StatelessWidget {
  final QuickAccessItem item;

  const _QuickAccessButton({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F2650).withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF1E4380).withValues(alpha: 0.7),
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: item.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: const Color(0xFF38BDF8),
                  size: 24,
                ),
                const SizedBox(height: 7),
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

