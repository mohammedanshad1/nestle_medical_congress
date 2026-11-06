import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'sprout_emblem.dart';

class FeaturedEventCard extends StatelessWidget {
  final VoidCallback? onTap;

  const FeaturedEventCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF102A58).withValues(alpha: 0.78),
            const Color(0xFF0C2044).withValues(alpha: 0.84),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF1E4685).withValues(alpha: 0.8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // "FEATURED EVENT" Golden Pill Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 4.5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.goldBorder.withValues(alpha: 0.85),
                            width: 1.1,
                          ),
                          color: AppColors.goldAccent.withValues(alpha: 0.08),
                        ),
                        child: Text(
                          'FEATURED EVENT',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.goldAccent,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Title: The Next Era of Nutrition & Health
                      Text(
                        'The Next Era of\nNutrition & Health',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          height: 1.24,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Date and Venue
                      Text(
                        'May 22 - 23, 2026  •  Dubai, UAE',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF90ADD9),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Sprout Nutrition Symbol
                const SproutEmblem(size: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

