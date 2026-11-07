import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/background_pattern.dart';
import '../widgets/badge_qr_code.dart';

class NameTagScreen extends StatelessWidget {
  final String attendeeName;
  final String attendeeRole;
  final String badgeId;
  final String location;
  final String congressDate;

  const NameTagScreen({
    super.key,
    this.attendeeName = 'Huda Latheef',
    this.attendeeRole = 'Flutter Developer • Attendee',
    this.badgeId = 'NMC-2026-001',
    this.location = 'Dubai, UAE',
    this.congressDate = '22 - 23 May 2026',
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.backgroundBottom,
        body: Stack(
          children: [
            // Dark Royal Navy Gradient Background
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.backgroundTop,
                      AppColors.backgroundMid,
                      AppColors.backgroundBottom,
                    ],
                  ),
                ),
              ),
            ),

            // Background Organic Waves
            Positioned.fill(
              child: CustomPaint(painter: BackgroundPatternPainter()),
            ),

            // Main Content Area
            SafeArea(
              child: Column(
                children: [
                  // App Bar (Back Button + Title aligned left + Print Action pushed right)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        // Back Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF0F2650,
                                ).withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(
                                    0xFF1E4380,
                                  ).withValues(alpha: 0.6),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.chevron_left_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Title (Now on the left)
                        Text(
                          'My Name Tag',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),

                        // Spacer to push the print button to the right
                        const Spacer(),

                        // Print / Export Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Printing digital badge for $attendeeName...',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  backgroundColor: AppColors.primaryBlue,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF0F2650,
                                ).withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(
                                    0xFF1E4380,
                                  ).withValues(alpha: 0.6),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.print_rounded,
                                color: Color(0xFFFDC55A),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Scrollable Badge Pass Card
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                        vertical: context.responsiveVerticalPadding,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: context.responsiveValue(
                              mobile: 420.0,
                              tablet: 520.0,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(
                              context.responsiveValue(
                                mobile: 20.0,
                                smallPhone: 14.0,
                                tablet: 26.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(34),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.22),
                                  blurRadius: 28,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Top Gradient Header Banner
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF38BDF8),
                                        Color(0xFF0D6BF5),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF0D6BF5,
                                        ).withValues(alpha: 0.35),
                                        blurRadius: 14,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'NESTLÉ MEDICAL',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.4,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'CONGRESS 2026',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.goldAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 22),

                                // Profile Avatar with Dual-Tone Gradient Ring
                                Container(
                                  width: 98,
                                  height: 98,

                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const SweepGradient(
                                      colors: [
                                        Color(0xFFFDC55A),
                                        Color(0xFF38BDF8),
                                        Color(0xFFFDC55A),
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(3.5),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'HL',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.primaryBlue,
                                          fontSize: 34,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 14),

                                // Attendee Name
                                Text(
                                  attendeeName,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: AppColors.textDark,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // Role & Subtitle
                                Text(
                                  attendeeRole,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(0xFF64748B),
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Golden Ribbon Medal Icon
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: AppColors.goldAccent.withValues(
                                          alpha: 0.15,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.verified_rounded,
                                        color: AppColors.goldAccent,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Information Tiles
                                _buildInfoTile(
                                  icon: Icons.badge_outlined,
                                  label: 'Badge ID',
                                  value: badgeId,
                                ),
                                const SizedBox(height: 10),

                                _buildInfoTile(
                                  icon: Icons.location_on_outlined,
                                  label: 'Location',
                                  value: location,
                                ),
                                const SizedBox(height: 10),

                                _buildInfoTile(
                                  icon: Icons.calendar_month_outlined,
                                  label: 'Congress Date',
                                  value: congressDate,
                                ),

                                const SizedBox(height: 18),

                                // QR Code Section
                                const BadgeQrCode(size: 100),

                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF94A3B8),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textDark,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
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
