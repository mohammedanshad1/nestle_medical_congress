import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/background_pattern.dart';
import '../widgets/featured_event_card.dart';
import '../widgets/quick_access_grid.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/upcoming_session_card.dart';
import 'agenda_screen.dart';
import 'ask_qa_screen.dart';
import 'live_voting_screen.dart';
import 'name_tag_screen.dart';
import 'profile_screen.dart';
import 'quick_access_screen.dart';
import 'resources_screen.dart';
import 'speakers_screen.dart';
import 'venue_screen.dart';

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
        body: IndexedStack(
          index: _currentTabIndex,
          children: [_buildHomeContent(), const ProfileScreen()],
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
          child: CustomPaint(painter: BackgroundPatternPainter()),
        ),

        // Scrollable Content
        SafeArea(
          bottom: false,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: context.responsiveVerticalPadding,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.responsiveValue(
                    mobile: 480.0,
                    tablet: 640.0,
                  ),
                ),
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
                      onTap: () =>
                          _showFeatureNotice('Featured Event: The Next Era'),
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
                  fontSize: context.responsiveValue(
                    mobile: 27.0,
                    smallPhone: 22.0,
                    tablet: 32.0,
                  ),
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
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
        ),
        const SizedBox(width: 8),
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
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AgendaScreen()));
        },
      ),
      QuickAccessItem(
        title: 'Speakers',
        icon: Icons.groups_outlined,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SpeakersScreen()),
          );
        },
      ),
      QuickAccessItem(
        title: 'Name Tag',
        icon: Icons.badge_outlined,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NameTagScreen()),
          );
        },
      ),
      QuickAccessItem(
        title: 'Venue',
        icon: Icons.location_on_outlined,
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const VenueScreen()));
        },
      ),
      QuickAccessItem(
        title: 'Voting',
        icon: Icons.bar_chart_rounded,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LiveVotingScreen()),
          );
        },
      ),
      QuickAccessItem(
        title: 'Ask Q&A',
        icon: Icons.chat_bubble_outline_rounded,
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AskQAScreen()));
        },
      ),
      QuickAccessItem(
        title: 'Resources',
        icon: Icons.folder_outlined,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ResourcesScreen()),
          );
        },
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
          categoryColor: AppColors.goldAccent,
          icon: Icons.calendar_today_outlined,
          title: 'Opening Ceremony',
          subtitle: 'Main Auditorium',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AgendaScreen()),
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
              MaterialPageRoute(builder: (context) => const AgendaScreen()),
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
              MaterialPageRoute(builder: (context) => const AgendaScreen()),
            );
          },
        ),
      ],
    );
  }

  // Bottom Navigation Bar with Home and Profile Tabs
  Widget _buildBottomNavigationBar() {
    final bottomInset = context.screenPadding.bottom;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF061226).withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: Color(0xFF12284C), width: 1.0),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        context.responsiveValue(mobile: 16.0, smallPhone: 10.0, tablet: 24.0),
        8,
        context.responsiveValue(mobile: 16.0, smallPhone: 10.0, tablet: 24.0),
        bottomInset > 0 ? bottomInset + 4 : 16,
      ),
      child: Row(
        children: [
          // Home Tab (Half Portion)
          Expanded(
            child: _buildNavItem(
              index: 0,
              icon: Icons.home_rounded,
              label: 'Home',
              isSelected: _currentTabIndex == 0,
            ),
          ),
          const SizedBox(width: 8),
          // Profile Tab (Half Portion)
          Expanded(
            child: _buildNavItem(
              index: 1,
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              isSelected: _currentTabIndex == 1,
            ),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0F3268).withValues(alpha: 0.9)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1E4D94).withValues(alpha: 0.8)
                : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
