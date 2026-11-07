import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/background_pattern.dart';
import '../widgets/map_preview_painter.dart';

class VenueFacilityItem {
  final String title;
  final IconData icon;

  const VenueFacilityItem({required this.title, required this.icon});
}

class VenueScreen extends StatelessWidget {
  final String venueName;
  final String dates;
  final String address;

  const VenueScreen({
    super.key,
    this.venueName = 'Dubai International\nConvention & Exhibition\nCenter',
    this.dates = '22 - 23 May 2026',
    this.address = 'World Trade Centre, Dubai,\nUnited Arab Emirates',
  });

  final List<VenueFacilityItem> _facilities = const [
    VenueFacilityItem(title: 'Free Wi-Fi', icon: Icons.wifi_rounded),
    VenueFacilityItem(title: 'Parking', icon: Icons.local_parking_rounded),
    VenueFacilityItem(title: 'Catering', icon: Icons.restaurant_rounded),
    VenueFacilityItem(title: 'Accessible', icon: Icons.accessible_rounded),
  ];

  void _showNotice(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

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

            // Scrollable Content
            SafeArea(
              child: Column(
                children: [
                  // App Bar (Back Button + Title aligned left + Direction Action pushed right)
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
                          'Venue',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),

                        // Spacer to push the direction action to the right
                        const Spacer(),

                        // Direction / Navigation Action
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => _showNotice(
                              context,
                              'Opening map directions to venue...',
                            ),
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
                                Icons.navigation_rounded,
                                color: Color(0xFFFDC55A),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Scrollable Area
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
                              mobile: 440.0,
                              tablet: 620.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Hero Banner: Venue Name & Dates
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(
                                        0xFF102A58,
                                      ).withValues(alpha: 0.78),
                                      const Color(
                                        0xFF0C2044,
                                      ).withValues(alpha: 0.84),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF1E4685,
                                    ).withValues(alpha: 0.8),
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.22,
                                      ),
                                      blurRadius: 18,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      venueName,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        height: 1.28,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Color(0xFF38BDF8),
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          dates,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFFCBD5E1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Card 1: Venue Address Card
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Light Blue Location Squircle
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE0F2FE),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(
                                        Icons.location_on_rounded,
                                        color: AppColors.primaryBlue,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 14),

                                    // Address Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Venue Address',
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF64748B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            address,
                                            style: GoogleFonts.plusJakartaSans(
                                              color: AppColors.textDark,
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w800,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Card 2: Map Preview Card
                              Container(
                                height: context.responsiveValue(
                                  mobile: 200.0,
                                  smallPhone: 160.0,
                                  tablet: 260.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 18,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: Stack(
                                    children: [
                                      // Map graphics canvas
                                      Positioned.fill(
                                        child: CustomPaint(
                                          painter: MapPreviewPainter(),
                                        ),
                                      ),

                                      // "Map Preview" Pill Chip at Top-Left
                                      Positioned(
                                        top: 14,
                                        left: 14,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 7,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.08,
                                                ),
                                                blurRadius: 10,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            'Map Preview',
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF0C1D36),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: -0.2,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Center Amber Beacon with Location Pin
                                      Center(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // Soft Diffused Golden Ambient Glow
                                            Container(
                                              width: 66,
                                              height: 66,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: const Color(
                                                      0xFFFDC55A,
                                                    ).withValues(alpha: 0.45),
                                                    blurRadius: 16,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Solid Warm Pastel Gold Circle
                                            Container(
                                              width: 58,
                                              height: 58,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFF7C866),
                                              ),
                                            ),
                                            // Dark Navy Location Pin
                                            const Icon(
                                              Icons.location_on_rounded,
                                              color: Color(0xFF0F2650),
                                              size: 28,
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Tap Area for Full Map Directions
                                      Positioned.fill(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              26,
                                            ),
                                            onTap: () => _showNotice(
                                              context,
                                              'Opening interactive venue map...',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Card 3: Venue Facilities Card
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Venue Facilities',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textDark,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 14),

                                    // 2x2 Facilities Grid
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildFacilityCard(
                                            context,
                                            _facilities[0],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: _buildFacilityCard(
                                            context,
                                            _facilities[1],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildFacilityCard(
                                            context,
                                            _facilities[2],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: _buildFacilityCard(
                                            context,
                                            _facilities[3],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),
                            ],
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

  Widget _buildFacilityCard(BuildContext context, VenueFacilityItem facility) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showNotice(context, '${facility.title} details'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Icon(facility.icon, color: AppColors.primaryBlue, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    facility.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
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
