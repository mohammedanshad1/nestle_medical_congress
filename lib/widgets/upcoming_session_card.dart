import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class UpcomingSessionCard extends StatefulWidget {
  final String time;
  final String period;
  final String category;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color categoryColor;
  final VoidCallback? onTap;

  const UpcomingSessionCard({
    super.key,
    required this.time,
    required this.period,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.categoryColor = const Color(0xFFFDC55A),
    this.onTap,
  });

  @override
  State<UpcomingSessionCard> createState() => _UpcomingSessionCardState();
}

class _UpcomingSessionCardState extends State<UpcomingSessionCard> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFDE68A).withValues(alpha: 0.6),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Time Column
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.time,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.primaryBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      widget.period,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF64748B),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),

                // Icon Squircle
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7).withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.categoryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.category.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          color: widget.categoryColor,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.7,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: const Color(0xFF94A3B8),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF64748B),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bookmark Icon
                IconButton(
                  icon: Icon(
                    _isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_outline_rounded,
                    color: _isBookmarked
                        ? AppColors.primaryBlue
                        : const Color(0xFF94A3B8),
                    size: 22,
                  ),
                  onPressed: () {
                    setState(() {
                      _isBookmarked = !_isBookmarked;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

