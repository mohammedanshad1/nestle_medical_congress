import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/background_pattern.dart';

class CongressSession {
  final String id;
  final int day;
  final String time;
  final String period;
  final String category;
  final String title;
  final String locationOrSpeaker;
  final IconData icon;
  final Color categoryColor;
  final Color iconBgColor;
  final bool hasGoldenBorder;

  const CongressSession({
    required this.id,
    required this.day,
    required this.time,
    required this.period,
    required this.category,
    required this.title,
    required this.locationOrSpeaker,
    required this.icon,
    required this.categoryColor,
    required this.iconBgColor,
    this.hasGoldenBorder = false,
  });
}

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  int _selectedDay = 1;
  String _selectedCategory = 'All';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _bookmarkedSessionIds = {};

  final List<String> _categories = const [
    'All',
    'Keynote',
    'Nutrition',
    'Research',
  ];

  final List<CongressSession> _allSessions = const [
    // Day 1 Sessions
    CongressSession(
      id: 'd1_s1',
      day: 1,
      time: '08:30',
      period: 'AM',
      category: 'Keynote',
      title: 'Opening Ceremony',
      locationOrSpeaker: 'Main Auditorium',
      icon: Icons.calendar_today_outlined,
      categoryColor: Color(0xFFFDC55A),
      iconBgColor: Color(0xFFFEF3C7),
      hasGoldenBorder: true,
    ),
    CongressSession(
      id: 'd1_s2',
      day: 1,
      time: '09:30',
      period: 'AM',
      category: 'Keynote',
      title: 'Welcome &\nIntroduction',
      locationOrSpeaker: 'Dr. Hassan Ali',
      icon: Icons.mic_none_rounded,
      categoryColor: Color(0xFF0284C7),
      iconBgColor: Color(0xFFE0F2FE),
      hasGoldenBorder: false,
    ),
    CongressSession(
      id: 'd1_s3',
      day: 1,
      time: '10:30',
      period: 'AM',
      category: 'Nutrition',
      title: 'Future of Pediatric\nNutrition',
      locationOrSpeaker: 'Dr. Sarah Johnson',
      icon: Icons.eco_rounded,
      categoryColor: Color(0xFF0284C7),
      iconBgColor: Color(0xFFE0F2FE),
      hasGoldenBorder: false,
    ),
    CongressSession(
      id: 'd1_s4',
      day: 1,
      time: '11:45',
      period: 'AM',
      category: 'Research',
      title: 'Clinical Trial Updates on Infant Growth',
      locationOrSpeaker: 'Dr. Ahmed Khalid',
      icon: Icons.science_outlined,
      categoryColor: Color(0xFF8B5CF6),
      iconBgColor: Color(0xFFF3E8FF),
      hasGoldenBorder: false,
    ),
    CongressSession(
      id: 'd1_s5',
      day: 1,
      time: '02:00',
      period: 'PM',
      category: 'Nutrition',
      title: 'Modern Approaches to Malnutrition',
      locationOrSpeaker: 'Hall B',
      icon: Icons.health_and_safety_outlined,
      categoryColor: Color(0xFF10B981),
      iconBgColor: Color(0xFFD1FAE5),
      hasGoldenBorder: false,
    ),

    // Day 2 Sessions
    CongressSession(
      id: 'd2_s1',
      day: 2,
      time: '09:00',
      period: 'AM',
      category: 'Keynote',
      title: 'Global Nutrition Policies & Trends',
      locationOrSpeaker: 'Main Auditorium',
      icon: Icons.public_rounded,
      categoryColor: Color(0xFFFDC55A),
      iconBgColor: Color(0xFFFEF3C7),
      hasGoldenBorder: true,
    ),
    CongressSession(
      id: 'd2_s2',
      day: 2,
      time: '10:30',
      period: 'AM',
      category: 'Nutrition',
      title: 'Advances in Prebiotic & Probiotic Formulas',
      locationOrSpeaker: 'Dr. Elena Rostova',
      icon: Icons.biotech_outlined,
      categoryColor: Color(0xFF0284C7),
      iconBgColor: Color(0xFFE0F2FE),
      hasGoldenBorder: false,
    ),
    CongressSession(
      id: 'd2_s3',
      day: 2,
      time: '01:30',
      period: 'PM',
      category: 'Research',
      title: 'Microbiome Diversity in Early Childhood',
      locationOrSpeaker: 'Dr. Michael Chang',
      icon: Icons.coronavirus_outlined,
      categoryColor: Color(0xFF8B5CF6),
      iconBgColor: Color(0xFFF3E8FF),
      hasGoldenBorder: false,
    ),
    CongressSession(
      id: 'd2_s4',
      day: 2,
      time: '03:30',
      period: 'PM',
      category: 'Keynote',
      title: 'Closing Remarks & Awards Ceremony',
      locationOrSpeaker: 'Main Auditorium',
      icon: Icons.emoji_events_outlined,
      categoryColor: Color(0xFFFDC55A),
      iconBgColor: Color(0xFFFEF3C7),
      hasGoldenBorder: true,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CongressSession> get _filteredSessions {
    final query = _searchController.text.trim().toLowerCase();
    return _allSessions.where((session) {
      final matchesDay = session.day == _selectedDay;
      final matchesCategory =
          _selectedCategory == 'All' ||
          session.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesQuery =
          query.isEmpty ||
          session.title.toLowerCase().contains(query) ||
          session.locationOrSpeaker.toLowerCase().contains(query);
      return matchesDay && matchesCategory && matchesQuery;
    }).toList();
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = 'All';
      _searchController.clear();
      _isSearching = false;
    });
  }

  void _toggleBookmark(String sessionId) {
    setState(() {
      if (_bookmarkedSessionIds.contains(sessionId)) {
        _bookmarkedSessionIds.remove(sessionId);
      } else {
        _bookmarkedSessionIds.add(sessionId);
      }
    });
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

            // Background Curves & Dots Pattern
            Positioned.fill(
              child: CustomPaint(painter: BackgroundPatternPainter()),
            ),

            // Main Content Area
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar (Back Button + Title aligned left + Search Icon pushed right)
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
                          'Congress Agenda',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),

                        // Spacer to push the search icon to the right
                        const Spacer(),

                        // Search Icon Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              setState(() {
                                _isSearching = !_isSearching;
                                if (!_isSearching) _searchController.clear();
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
                                _isSearching
                                    ? Icons.close_rounded
                                    : Icons.search_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Optional Inline Search Bar
                  if (_isSearching)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                        vertical: 6,
                      ),
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F2650).withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF1E4685),
                            width: 1.1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF94A3B8),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                onChanged: (_) => setState(() {}),
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      'Search session title or speaker...',
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                    color: const Color(0xFF94A3B8),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Hero Banner Card ("Day X Schedule")
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 6,
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
                          // Warm Amber Calendar Icon Badge
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFFFD988), Color(0xFFFDC55A)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFDC55A,
                                  ).withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.calendar_month_rounded,
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
                                  _selectedDay == 1
                                      ? 'Day 1 Schedule'
                                      : 'Day 2 Schedule',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _selectedDay == 1
                                      ? 'Thursday, May 22, 2026'
                                      : 'Friday, May 23, 2026',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(0xFFCBD5E1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Day Switcher Tabs (Day 1 / Day 2)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                    ),
                    child: Row(
                      children: [
                        // Day 1 Tab
                        Expanded(
                          child: _buildDayTab(
                            dayNumber: 1,
                            title: 'Day 1',
                            subtitle: 'May 22',
                            isSelected: _selectedDay == 1,
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Day 2 Tab
                        Expanded(
                          child: _buildDayTab(
                            dayNumber: 2,
                            title: 'Day 2',
                            subtitle: 'May 23',
                            isSelected: _selectedDay == 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

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
                          const SizedBox(height: 20),

                          // Header: "Today's Sessions" + "Reset" Action
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Today's Sessions",
                                  style: GoogleFonts.plusJakartaSans(
                                    color: AppColors.textDark,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _resetFilters,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.refresh_rounded,
                                        color: AppColors.primaryBlue,
                                        size: 17,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Reset',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.primaryBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Category Filter Pills (All, Keynote, Nutrition, Research)
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

                          const SizedBox(height: 14),

                          // Sessions List
                          Expanded(
                            child: _filteredSessions.isEmpty
                                ? Center(
                                    child: Text(
                                      'No sessions found for this filter.',
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
                                    itemCount: _filteredSessions.length,
                                    itemBuilder: (context, index) {
                                      final session = _filteredSessions[index];
                                      return _buildSessionCard(session);
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

  // Day Tab Button
  Widget _buildDayTab({
    required int dayNumber,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = dayNumber;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.goldAccent
              : const Color(0xFF0F2650).withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.goldAccent
                : const Color(0xFF1E4380).withValues(alpha: 0.7),
            width: 1.1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.goldAccent.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                color: isSelected ? AppColors.textDark : Colors.white,
                fontSize: 15.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.plusJakartaSans(
                color: isSelected
                    ? const Color(0xFF334155)
                    : const Color(0xFF94A3B8),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Session Card
  Widget _buildSessionCard(CongressSession session) {
    final isBookmarked = _bookmarkedSessionIds.contains(session.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: session.hasGoldenBorder
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
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${session.title.replaceAll('\n', ' ')} selected',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: AppColors.primaryBlue,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Time Column (e.g. "08:30" / "0" / "AM")
                SizedBox(
                  width: 52,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        session.time,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.primaryBlue,
                          fontSize: 16.5,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        session.period,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF64748B),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Icon Squircle
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: session.iconBgColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    session.icon,
                    color: session.categoryColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),

                // Content Column (Category + Title + Location/Speaker)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        session.category.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          color: session.categoryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        session.title,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textDark,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 3),
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
                              session.locationOrSpeaker,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF64748B),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bookmark Icon Button
                IconButton(
                  icon: Icon(
                    isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_outline_rounded,
                    color: isBookmarked
                        ? AppColors.primaryBlue
                        : const Color(0xFF94A3B8),
                    size: 22,
                  ),
                  onPressed: () => _toggleBookmark(session.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
