import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../widgets/background_pattern.dart';
import '../widgets/featured_event_card.dart';
import '../widgets/quick_access_grid.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/upcoming_session_card.dart';
import 'agenda_screen.dart';
import 'name_tag_screen.dart';
import 'profile_screen.dart';
import 'quick_access_screen.dart';
import 'speakers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFeatureNotice(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$title feature selected',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
        body: IndexedStack(
          index: _currentTabIndex,
          children: [
            _buildHomeContent(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildHomeContent() {
    return Stack(
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

        // Background Wave Lines & Decorative Dot Grid
        Positioned.fill(
          child: CustomPaint(
            painter: BackgroundPatternPainter(),
          ),
        ),

        // Scrollable Content
        SafeArea(
          bottom: false,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar: Congress Subtitle + Welcome Greeting + Notification Bell
                    _buildTopHeader(),

                    const SizedBox(height: 18),

                    // Search Bar with Filter Button
                    SearchFilterBar(
                      controller: _searchController,
                      onFilterTap: () => _showFeatureNotice('Search Filters'),
                    ),

                    const SizedBox(height: 18),

                    // Featured Event Card: "The Next Era of Nutrition & Health"
                    FeaturedEventCard(
                      onTap: () => _showFeatureNotice('Featured Event: The Next Era'),
                    ),

                    const SizedBox(height: 22),

                    // Quick Access Header & Grid
                    _buildSectionHeader(
                      title: 'Quick Access',
                      actionText: 'View All >',
                      onActionTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const QuickAccessScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildQuickAccessGrid(),

                    const SizedBox(height: 22),

                    // Upcoming Sessions Header & List
                    _buildSectionHeader(
                      title: 'Upcoming Sessions',
                      actionText: 'View All >',
                      onActionTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AgendaScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildUpcomingSessionsList(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Top Bar Header
  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NESTLÉ MEDICAL CONGRESS',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome Back,\nDr. Testing 👋',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),

        // Notification Bell Icon with Red Dot Indicator
        GestureDetector(
          onTap: () => _showFeatureNotice('Notifications'),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF0F2650).withValues(alpha: 0.65),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF1E4380).withValues(alpha: 0.7),
                width: 1.0,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                Positioned(
                  top: 9,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Section Header with Title and "View All >"
  Widget _buildSectionHeader({
    required String title,
    required String actionText,
    required VoidCallback onActionTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF38BDF8),
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // Quick Access 8-Button Grid
  Widget _buildQuickAccessGrid() {
    final List<QuickAccessItem> items = [
      QuickAccessItem(
        title: 'Agenda',
        icon: Icons.calendar_month_outlined,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AgendaScreen(),
            ),
          );
        },
      ),
      QuickAccessItem(
        title: 'Speakers',
        icon: Icons.groups_outlined,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SpeakersScreen(),
            ),
          );
        },
      ),
      QuickAccessItem(
        title: 'Name Tag',
        icon: Icons.badge_outlined,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NameTagScreen(),
            ),
          );
        },
      ),
      QuickAccessItem(
        title: 'Venue',
        icon: Icons.location_on_outlined,
        onTap: () => _showFeatureNotice('Venue'),
      ),
      QuickAccessItem(
        title: 'Voting',
        icon: Icons.bar_chart_rounded,
        onTap: () => _showFeatureNotice('Voting'),
      ),
      QuickAccessItem(
        title: 'Ask Q&A',
        icon: Icons.chat_bubble_outline_rounded,
        onTap: () => _showFeatureNotice('Ask Q&A'),
      ),
      QuickAccessItem(
        title: 'Resources',
        icon: Icons.folder_outlined,
        onTap: () => _showFeatureNotice('Resources'),
      ),
      QuickAccessItem(
        title: 'Exhibitors',
        icon: Icons.storefront_outlined,
        onTap: () => _showFeatureNotice('Exhibitors'),
      ),
    ];

    return QuickAccessGrid(items: items);
  }

  // Upcoming Sessions List
  Widget _buildUpcomingSessionsList() {
    return Column(
      children: [
        UpcomingSessionCard(
          time: '08:30',
          period: 'AM',
          category: 'Keynote',
          categoryColor: const Color(0xFFF59E0B),
          icon: Icons.calendar_today_outlined,
          title: 'Opening Ceremony',
          subtitle: 'Main Auditorium',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AgendaScreen(),
              ),
            );
          },
        ),
        UpcomingSessionCard(
          time: '09:30',
          period: 'AM',
          category: 'Keynote',
          categoryColor: const Color(0xFF0D6BF5),
          icon: Icons.mic_none_rounded,
          title: 'Welcome & Introduction',
          subtitle: 'Dr. Hassan Ali',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AgendaScreen(),
              ),
            );
          },
        ),
        UpcomingSessionCard(
          time: '10:30',
          period: 'AM',
          category: 'Nutrition',
          categoryColor: const Color(0xFF10B981),
          icon: Icons.eco_outlined,
          title: 'Future of Pediatric Nutrition',
          subtitle: 'Dr. Sarah Johnson',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AgendaScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  // Bottom Navigation Bar with Home and Profile Tabs
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF061226).withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(
            color: Color(0xFF12284C),
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home Tab
          _buildNavItem(
            index: 0,
            icon: Icons.home_rounded,
            label: 'Home',
            isSelected: _currentTabIndex == 0,
          ),
          // Profile Tab
          _buildNavItem(
            index: 1,
            icon: Icons.person_outline_rounded,
            label: 'Profile',
            isSelected: _currentTabIndex == 1,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _currentTabIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF0F3A7A).withValues(alpha: 0.8)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF38BDF8) : const Color(0xFF64748B),
              size: 22,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: isSelected ? Colors.white : const Color(0xFF64748B),
              fontSize: 11.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

