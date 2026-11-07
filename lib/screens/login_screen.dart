import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/apple_logo.dart';
import '../widgets/background_pattern.dart';
import '../widgets/congress_highlights_bar.dart';
import '../widgets/google_logo.dart';
import '../widgets/medical_shield_badge.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _navigateToRegister() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
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

            // Background Curves, Ambient Glow, and Dot Grid Matrix
            Positioned.fill(
              child: CustomPaint(painter: BackgroundPatternPainter()),
            ),

            // Scrollable Content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveHorizontalPadding,
                    vertical: context.responsiveVerticalPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.maxContentWidth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: context.responsiveValue(
                            mobile: 6.0,
                            smallPhone: 2.0,
                          ),
                        ),

                        // Top Golden Pill Badge: "NESTLÉ MEDICAL CONGRESS"
                        _buildTopCongressBadge(),

                        SizedBox(
                          height: context.responsiveValue(
                            mobile: 16.0,
                            smallPhone: 8.0,
                          ),
                        ),

                        // Title: NESTLÉ CONGRESS
                        _buildCongressTitle(),

                        const SizedBox(height: 6),

                        // Gold Accent Bar
                        _buildGoldAccentBar(),

                        SizedBox(
                          height: context.responsiveValue(
                            mobile: 10.0,
                            smallPhone: 6.0,
                          ),
                        ),

                        // Subtitle: The Next Era of Nutrition & Health
                        _buildSubtitle(),

                        SizedBox(
                          height: context.responsiveValue(
                            mobile: 20.0,
                            smallPhone: 12.0,
                          ),
                        ),

                        // White "Welcome Back" Card
                        _buildWelcomeCard(),

                        SizedBox(
                          height: context.responsiveValue(
                            mobile: 18.0,
                            smallPhone: 12.0,
                          ),
                        ),

                        // "Don't have an account? Create Account ->"
                        _buildBottomAccountPrompt(),

                        SizedBox(
                          height: context.responsiveValue(
                            mobile: 16.0,
                            smallPhone: 10.0,
                          ),
                        ),

                        // Bottom Highlights Info Bar
                        const CongressHighlightsBar(),

                        SizedBox(
                          height: context.responsiveValue(
                            mobile: 12.0,
                            smallPhone: 6.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top Pill Badge
  Widget _buildTopCongressBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.goldBorder.withValues(alpha: 0.85),
          width: 1.2,
        ),
      ),
      child: Text(
        'NESTLÉ MEDICAL CONGRESS',
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
    );
  }

  // Congress Title
  Widget _buildCongressTitle() {
    final titleFontSize = context.responsiveValue(
      mobile: 36.0,
      smallPhone: 28.0,
      tablet: 42.0,
    );
    final congressFontSize = context.responsiveValue(
      mobile: 38.0,
      smallPhone: 30.0,
      tablet: 44.0,
    );

    return Column(
      children: [
        Text(
          'NESTLÉ',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.6,
            height: 1.05,
          ),
        ),
        Text(
          'CONGRESS',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.goldAccent,
            fontSize: congressFontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
            height: 1.05,
          ),
        ),
      ],
    );
  }

  // Gold accent line under title
  Widget _buildGoldAccentBar() {
    return Container(
      width: 42,
      height: 3.2,
      decoration: BoxDecoration(
        color: AppColors.goldAccent,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // Subtitle
  Widget _buildSubtitle() {
    return Column(
      children: [
        Text(
          'The Next Era of',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFFCBD5E1),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
        Text(
          'Nutrition & Health',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFFCBD5E1),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  // Main White "Welcome Back" Card
  Widget _buildWelcomeCard() {
    final cardPadding = context.responsiveValue(
      mobile: 22.0,
      smallPhone: 16.0,
      tablet: 28.0,
    );
    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card Header: Welcome Back + Medical Shield Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textDark,
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Sign in to continue your congress\nexperience',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textMuted,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const MedicalShieldBadge(size: 52),
              ],
            ),

            const SizedBox(height: 20),

            // Email Input Field
            _buildInputField(
              controller: _emailController,
              hintText: 'Enter your email',
              icon: Icons.person_outline_rounded,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 14),

            // Password Input Field
            _buildInputField(
              controller: _passwordController,
              hintText: 'Enter your password',
              icon: Icons.lock_outline_rounded,
              isPassword: true,
              obscureText: _obscurePassword,
              onToggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),

            const SizedBox(height: 18),

            // Sign In Button
            _buildSignInButton(),

            const SizedBox(height: 18),

            // "OR CONTINUE WITH" Divider
            _buildDivider(),

            const SizedBox(height: 14),

            // Google & Apple Social Login Buttons
            Row(
              children: [
                Expanded(
                  child: _buildSocialButton(
                    child: const GoogleLogo(size: 21),
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Google Sign In tapped',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: AppColors.primaryBlue,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildSocialButton(
                    child: const AppleLogo(size: 24),
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Apple Sign In tapped',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: AppColors.primaryBlue,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Forgot Password Link
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Password reset link sent to your email!',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: AppColors.primaryBlue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.iconBlue,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Forgot password?',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.iconBlue,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Rounded Input Field Widget
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(22),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        keyboardType: keyboardType,
        validator: validator,
        style: GoogleFonts.plusJakartaSans(
          color: AppColors.textDark,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
            color: AppColors.textPlaceholder,
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Icon(icon, color: AppColors.iconBlue, size: 21),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 44,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textPlaceholder,
                    size: 20,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.inputBorder,
              width: 1.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.inputBorder,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.primaryBlue,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
        ),
      ),
    );
  }

  // Sign In Button
  Widget _buildSignInButton() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF0052D4), Color(0xFF0D6BF5), Color(0xFF00B4D8)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D6BF5).withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: _handleSignIn,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // "OR CONTINUE WITH" Divider
  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR CONTINUE WITH',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF9CA3AF),
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 1)),
      ],
    );
  }

  // Social Button Widget
  Widget _buildSocialButton({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }

  // "Don't have an account? Create Account ->"
  Widget _buildBottomAccountPrompt() {
    return GestureDetector(
      onTap: _navigateToRegister,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFCBD5E1),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Create Account',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.goldAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.goldAccent,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
