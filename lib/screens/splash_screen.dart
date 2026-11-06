import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/background_pattern.dart';
import '../widgets/sprout_emblem.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  final bool autoNavigate;
  final Duration duration;

  const SplashScreen({
    super.key,
    this.autoNavigate = true,
    this.duration = const Duration(milliseconds: 2200),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _progressAnimation;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.95, curve: Curves.easeInOut),
      ),
    );

    if (widget.autoNavigate) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          _navigateToLogin();
        }
      });
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    if (_navigated || !mounted) return;
    _navigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  String _getStatusText(double progress) {
    if (progress < 0.35) {
      return 'Initializing congress portal...';
    } else if (progress < 0.75) {
      return 'Syncing scientific agenda & speakers...';
    } else {
      return 'Welcome, Doctor';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.backgroundBottom,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _navigateToLogin,
          child: Stack(
            children: [
              // Deep Royal Midnight Navy Gradient
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

              // Ambient Light Aura Top-Right (Cyan Glow)
              Positioned(
                top: -60,
                right: -60,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF38BDF8).withValues(alpha: 0.22),
                        blurRadius: 100,
                        spreadRadius: 40,
                      ),
                    ],
                  ),
                ),
              ),

              // Ambient Light Aura Center (Golden Amber Glow)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                left: MediaQuery.of(context).size.width * 0.2,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF7BA2C).withValues(alpha: 0.16),
                        blurRadius: 120,
                        spreadRadius: 35,
                      ),
                    ],
                  ),
                ),
              ),

              // Ambient Light Aura Bottom-Left (Royal Electric Blue)
              Positioned(
                bottom: -40,
                left: -40,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0D6BF5).withValues(alpha: 0.20),
                        blurRadius: 90,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),
              ),

              // Subtle Background Dot Grid & Waves
              Positioned.fill(
                child: CustomPaint(
                  painter: BackgroundPatternPainter(),
                ),
              ),

              // Foreground Animated Content
              SafeArea(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final progress = _progressAnimation.value;
                    final hPad = context.responsiveHorizontalPadding;
                    final isSmall = context.isSmallPhone;
                    final isLandscape = context.isLandscape;
                    final emblemSize = context.responsiveValue(
                      mobile: isLandscape ? 90.0 : 136.0,
                      smallPhone: 100.0,
                      tablet: 160.0,
                    );
                    final titleSize = context.responsiveValue(
                      mobile: 28.0,
                      smallPhone: 22.0,
                      tablet: 34.0,
                    );

                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Center(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: hPad,
                              vertical: isSmall ? 10 : 20,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: context.maxContentWidth,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: isSmall || isLandscape ? 8 : 24),

                                  // Central Crest Emblem
                                  _buildCentralEmblem(emblemSize),

                                  SizedBox(height: isSmall || isLandscape ? 16 : 28),

                                  // Golden Overline with Diamonds
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.diamond_rounded,
                                        size: 11,
                                        color: AppColors.goldAccent,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'NESTLÉ HEALTH SCIENCE',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.goldAccent,
                                          fontSize: isSmall ? 10.5 : 12,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: isSmall ? 1.8 : 2.8,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.diamond_rounded,
                                        size: 11,
                                        color: AppColors.goldAccent,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // Main Congress Title
                                  Text(
                                    'NESTLÉ MEDICAL\nCONGRESS',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: titleSize,
                                      fontWeight: FontWeight.w900,
                                      height: 1.15,
                                      letterSpacing: -0.5,
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.4),
                                          blurRadius: 16,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Edition & Year Pill
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmall ? 10 : 14,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFF7BA2C),
                                          Color(0xFFF59E0B),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFF59E0B)
                                              .withValues(alpha: 0.35),
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'ANNUAL GLOBAL EDITION 2026',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xFF0B1938),
                                        fontSize: isSmall ? 9.5 : 11,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: isSmall || isLandscape ? 10 : 16),

                                  // Theme Tagline
                                  Text(
                                    'The Next Era of Nutrition & Health',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: const Color(0xFFCBD5E1),
                                      fontSize: isSmall ? 12.5 : 14.5,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.1,
                                    ),
                                  ),

                                  SizedBox(height: isSmall || isLandscape ? 12 : 20),

                                  // Venue & Date Frosted Capsule
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmall ? 12 : 16,
                                      vertical: isSmall ? 6 : 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0F2650)
                                          .withValues(alpha: 0.65),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: const Color(0xFF1E4380)
                                            .withValues(alpha: 0.7),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.location_on_rounded,
                                          color: Color(0xFF38BDF8),
                                          size: 15,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Vienna • May 22–24, 2026',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFFE2E8F0),
                                            fontSize: isSmall ? 11.5 : 12.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: isSmall || isLandscape ? 16 : 30),

                                  // Animated Progress Bar
                                  SizedBox(
                                    width: isSmall ? 160 : 200,
                                    height: 4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: Stack(
                                        children: [
                                          // Background track
                                          Container(
                                            color: const Color(0xFF152F5A),
                                          ),
                                          // Animated Fill
                                          FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: progress.clamp(0.0, 1.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFF38BDF8),
                                                    Color(0xFF0D6BF5),
                                                    Color(0xFFF7BA2C),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Progress Status Text
                                  Text(
                                    _getStatusText(progress),
                                    style: GoogleFonts.plusJakartaSans(
                                      color: const Color(0xFF94A3B8),
                                      fontSize: isSmall ? 11.5 : 12.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  SizedBox(height: isSmall || isLandscape ? 12 : 20),

                                  // Skip / Tap to continue hint
                                  Text(
                                    'Tap anywhere to continue →',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: const Color(0xFF64748B),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.4,
                                    ),
                                  ),

                                  SizedBox(height: isSmall || isLandscape ? 8 : 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Central Luxury Medical Emblem
  Widget _buildCentralEmblem([double size = 140]) {
    final double scale = size / 140.0;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Soft Glow Ring
          Container(
            width: 136 * scale,
            height: 136 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0D6BF5).withValues(alpha: 0.35),
                  blurRadius: 24 * scale,
                  spreadRadius: 4 * scale,
                ),
                BoxShadow(
                  color: const Color(0xFFF7BA2C).withValues(alpha: 0.20),
                  blurRadius: 36 * scale,
                  spreadRadius: 2 * scale,
                ),
              ],
            ),
          ),

          // Outer Concentric Circle with Thin Border
          Container(
            width: 130 * scale,
            height: 130 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
          ),

          // Secondary Dashed / Inner Ring
          Container(
            width: 116 * scale,
            height: 116 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF7BA2C).withValues(alpha: 0.35),
                width: 1.0,
              ),
            ),
          ),

          // High-End Frosted Glass Squircle
          Container(
            width: 98 * scale,
            height: 98 * scale,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF163772),
                  Color(0xFF0B1F45),
                ],
              ),
              borderRadius: BorderRadius.circular(26 * scale),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF050E20).withValues(alpha: 0.6),
                  blurRadius: 20 * scale,
                  offset: Offset(0, 8 * scale),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Medical Shield Background Icon
                Icon(
                  Icons.shield_rounded,
                  size: 64 * scale,
                  color: const Color(0xFF0D6BF5),
                ),

                // Sprout Emblem in Foreground
                SproutEmblem(size: 46 * scale),
              ],
            ),
          ),

          // Sparkle Accent Top Right
          Positioned(
            top: 6 * scale,
            right: 12 * scale,
            child: Container(
              padding: EdgeInsets.all(4 * scale),
              decoration: const BoxDecoration(
                color: Color(0xFFF7BA2C),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 10 * scale,
                color: const Color(0xFF07142E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

