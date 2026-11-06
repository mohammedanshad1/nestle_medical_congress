import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class CongressHighlightsBar extends StatelessWidget {
  const CongressHighlightsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.highlightsCardBg.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.highlightsBorder.withValues(alpha: 0.7),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _HighlightItem(
            icon: Icons.groups_outlined,
            titleLine1: 'Global',
            titleLine2: 'Experts',
          ),
          _HighlightItem(
            icon: Icons.event_available_outlined,
            titleLine1: 'Knowledge',
            titleLine2: 'Sessions',
          ),
          _HighlightItem(
            icon: Icons.star_outline_rounded,
            titleLine1: 'Networking',
            titleLine2: 'Opportunities',
          ),
        ],
      ),
    );
  }
}

class _HighlightItem extends StatelessWidget {
  final IconData icon;
  final String titleLine1;
  final String titleLine2;

  const _HighlightItem({
    required this.icon,
    required this.titleLine1,
    required this.titleLine2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.highlightsIconBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF1E4C8A).withValues(alpha: 0.4),
                width: 0.8,
              ),
            ),
            child: Icon(icon, color: AppColors.highlightsIcon, size: 19),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  titleLine1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),
                Text(
                  titleLine2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
