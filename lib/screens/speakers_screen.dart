import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/background_pattern.dart';

class SpeakerModel {
  final String id;
  final String name;
  final String initials;
  final String specialty;
  final String country;
  final String sessionTitle;
  final String category;
  final bool isFeatured;
  final String bio;

  const SpeakerModel({
    required this.id,
    required this.name,
    required this.initials,
    required this.specialty,
    required this.country,
    required this.sessionTitle,
    required this.category,
    this.isFeatured = false,
    required this.bio,
  });
}

class SpeakersScreen extends StatefulWidget {
  const SpeakersScreen({super.key});

  @override
  State<SpeakersScreen> createState() => _SpeakersScreenState();
}

class _SpeakersScreenState extends State<SpeakersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  bool _onlyFavorites = false;
  final Set<String> _favoriteSpeakerIds = {'dr_sarah'};

  final List<String> _categories = const [
    'All',
    'Nutrition',
    'Research',
    'Pediatrics',
    'Clinical',
  ];

  final List<SpeakerModel> _allSpeakers = const [
    SpeakerModel(
      id: 'dr_sarah',
      name: 'Dr. Sarah Johnson',
      initials: 'SJ',
      specialty: 'Pediatric Nutrition Specialist',
      country: 'United Kingdom',
      sessionTitle: 'Future of Pediatric Nutrition',
      category: 'Nutrition',
      isFeatured: true,
      bio:
          'Consultant in pediatric gastroenterology and clinical nutrition with over 18 years of clinical experience in early childhood metabolic development.',
    ),
    SpeakerModel(
      id: 'dr_hassan',
      name: 'Dr. Hassan Ali',
      initials: 'HA',
      specialty: 'Clinical Research Director',
      country: 'UAE',
      sessionTitle: 'Welcome & Introduction',
      category: 'Clinical',
      isFeatured: false,
      bio:
          'Senior medical director leading multi-center epidemiological and nutrition clinical trials across the Middle East and GCC region.',
    ),
    SpeakerModel(
      id: 'dr_ahmed',
      name: 'Dr. Ahmed Khalid',
      initials: 'AK',
      specialty: 'Infant Growth & Metabolism',
      country: 'Saudi Arabia',
      sessionTitle: 'Clinical Trial Updates on Infant Growth',
      category: 'Research',
      isFeatured: false,
      bio:
          'Associate professor of pediatrics focusing on clinical interventions in low birth weight and preterm infant nutrition.',
    ),
    SpeakerModel(
      id: 'dr_elena',
      name: 'Dr. Elena Rostova',
      initials: 'ER',
      specialty: 'Microbiome & Probiotics Researcher',
      country: 'Switzerland',
      sessionTitle: 'Advances in Prebiotic & Probiotic Formulas',
      category: 'Pediatrics',
      isFeatured: false,
      bio:
          'Head of gut microbiome research with published work on prebiotic oligosaccharides and infant immune response.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SpeakerModel> get _filteredSpeakers {
    final query = _searchController.text.trim().toLowerCase();
    return _allSpeakers.where((speaker) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          speaker.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesQuery =
          query.isEmpty ||
          speaker.name.toLowerCase().contains(query) ||
          speaker.specialty.toLowerCase().contains(query) ||
          speaker.country.toLowerCase().contains(query) ||
          speaker.sessionTitle.toLowerCase().contains(query);
      final matchesFavorites =
          !_onlyFavorites || _favoriteSpeakerIds.contains(speaker.id);
      return matchesCategory && matchesQuery && matchesFavorites;
    }).toList();
  }

  void _toggleFavorite(String speakerId) {
    setState(() {
      if (_favoriteSpeakerIds.contains(speakerId)) {
        _favoriteSpeakerIds.remove(speakerId);
      } else {
        _favoriteSpeakerIds.add(speakerId);
      }
    });
  }

  void _showSpeakerDetails(SpeakerModel speaker) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFEFF6FF),
                    child: Text(
                      speaker.initials,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.primaryBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          speaker.name,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          speaker.specialty,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF64748B),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 13,
                              color: Color(0xFF94A3B8),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              speaker.country,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF94A3B8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Biography',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                speaker.bio,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF475569),
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Congress Session',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  speaker.sessionTitle,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.primaryBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
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

            // Background Waves
            Positioned.fill(
              child: CustomPaint(painter: BackgroundPatternPainter()),
            ),

            // Main Content Area
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar (Back Button + Title aligned left + Star Toggle pushed right)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
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
                          'Speakers',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),

                        // Spacer to push the favorites toggle to the right
                        const Spacer(),

                        // Favorites Filter Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              setState(() {
                                _onlyFavorites = !_onlyFavorites;
                              });
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
                              child: Icon(
                                _onlyFavorites
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                color: const Color(0xFFFDC55A),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Hero Banner Card: "Global Medical Experts"
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 8,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(18),
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
                      child: Row(
                        children: [
                          // Bright Cyan/Blue Squircle Icon Badge
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF38BDF8), Color(0xFF0D6BF5)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF0D6BF5,
                                  ).withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.groups_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Text Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Global Medical\nExperts',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Meet speakers from nutrition,\nresearch and healthcare',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(0xFFCBD5E1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Main White Content Container
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 18),

                          // Search Bar with Filter Icon
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search_rounded,
                                    color: Color(0xFF94A3B8),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: (_) => setState(() {}),
                                      style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textDark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'Search speakers',
                                        hintStyle: GoogleFonts.plusJakartaSans(
                                          color: const Color(0xFF94A3B8),
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.tune_rounded,
                                    color: AppColors.primaryBlue,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Category Filter Pills
                          SizedBox(
                            height: 38,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              itemCount: _categories.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                final category = _categories[index];
                                final isSelected =
                                    _selectedCategory == category;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedCategory = category;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primaryBlue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primaryBlue
                                            : const Color(0xFFE2E8F0),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        category,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF64748B),
                                          fontSize: 13,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Speakers List
                          Expanded(
                            child: _filteredSpeakers.isEmpty
                                ? Center(
                                    child: Text(
                                      'No speakers found matching your search.',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    padding: const EdgeInsets.fromLTRB(
                                      20,
                                      2,
                                      20,
                                      24,
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: _filteredSpeakers.length,
                                    itemBuilder: (context, index) {
                                      final speaker = _filteredSpeakers[index];
                                      return _buildSpeakerCard(speaker);
                                    },
                                  ),
                          ),
                        ],
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

  // Individual Speaker Card Widget
  Widget _buildSpeakerCard(SpeakerModel speaker) {
    final isFavorite = _favoriteSpeakerIds.contains(speaker.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: speaker.isFeatured
              ? const Color(0xFFFDE68A)
              : const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _showSpeakerDetails(speaker),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar with Circular Gradient or Blue Ring
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: speaker.isFeatured
                          ? const Color(0xFF38BDF8)
                          : const Color(0xFF2563EB),
                      width: 2.2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      speaker.initials,
                      style: GoogleFonts.plusJakartaSans(
                        color: speaker.isFeatured
                            ? AppColors.primaryBlue
                            : const Color(0xFF1D4ED8),
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Middle Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge Tag: "FEATURED SPEAKER" or "SPEAKER"
                      Text(
                        speaker.isFeatured ? 'FEATURED SPEAKER' : 'SPEAKER',
                        style: GoogleFonts.plusJakartaSans(
                          color: speaker.isFeatured
                              ? const Color(0xFFFDC55A)
                              : AppColors.primaryBlue,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Speaker Name
                      Text(
                        speaker.name,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Specialty
                      Text(
                        speaker.specialty,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF64748B),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Location
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: Color(0xFF94A3B8),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            speaker.country,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF64748B),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Session Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          speaker.sessionTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF1D4ED8),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Column (Star Favorite + Chevron)
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: isFavorite
                            ? const Color(0xFFFDC55A)
                            : const Color(0xFFCBD5E1),
                        size: 23,
                      ),
                      onPressed: () => _toggleFavorite(speaker.id),
                    ),
                    const SizedBox(height: 12),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF94A3B8),
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
