import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/background_pattern.dart';
import 'agenda_screen.dart';
import 'ask_qa_screen.dart';
import 'live_voting_screen.dart';
import 'name_tag_screen.dart';
import 'resources_screen.dart';
import 'speakers_screen.dart';
import 'venue_screen.dart';

class QuickAccessTool {
  final String id;
  final String title;
  final String description;
  final String category;
  final IconData icon;

  const QuickAccessTool({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
  });
}

class QuickAccessScreen extends StatefulWidget {
  const QuickAccessScreen({super.key});

  @override
  State<QuickAccessScreen> createState() => _QuickAccessScreenState();
}

class _QuickAccessScreenState extends State<QuickAccessScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  bool _isGridView = true;

  final List<String> _categories = const [
    'All',
    'Event',
    'Interactive',
    'Tools',
  ];

  final List<QuickAccessTool> _tools = const [
    QuickAccessTool(
      id: 'agenda',
      title: 'Agenda',
      description: 'View full congress\nschedule',
      category: 'Event',
      icon: Icons.calendar_month_outlined,
    ),
    QuickAccessTool(
      id: 'speakers',
      title: 'Speakers',
      description: 'Explore global medical\nexperts',
      category: 'Event',
      icon: Icons.groups_outlined,
    ),
    QuickAccessTool(
      id: 'name_tag',
      title: 'Name Tag',
      description: 'Access your digital\nbadge',
      category: 'Tools',
      icon: Icons.badge_outlined,
    ),
    QuickAccessTool(
      id: 'venue',
      title: 'Venue',
      description: 'Location, facilities and\ndirections',
      category: 'Event',
      icon: Icons.location_on_outlined,
    ),
    QuickAccessTool(
      id: 'voting',
      title: 'Voting',
      description: 'Participate in live session\npolls',
      category: 'Interactive',
      icon: Icons.bar_chart_rounded,
    ),
    QuickAccessTool(
      id: 'ask_qa',
      title: 'Ask Q&A',
      description: 'Submit questions to\nspeakers',
      category: 'Interactive',
      icon: Icons.chat_bubble_outline_rounded,
    ),
    QuickAccessTool(
      id: 'resources',
      title: 'Resources',
      description: 'Congress library and\npresentations',
      category: 'Tools',
      icon: Icons.folder_outlined,
    ),
    QuickAccessTool(
      id: 'exhibitors',
      title: 'Exhibitors',
      description: 'Discover industry partners\nand booths',
      category: 'Event',
      icon: Icons.storefront_outlined,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<QuickAccessTool> get _filteredTools {
    final query = _searchController.text.trim().toLowerCase();
    return _tools.where((tool) {
      final matchesCategory =
          _selectedCategory == 'All' || tool.category == _selectedCategory;
      final matchesQuery =
          query.isEmpty ||
          tool.title.toLowerCase().contains(query) ||
          tool.description.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _onToolTap(QuickAccessTool tool) {
    if (tool.id == 'agenda') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const AgendaScreen()));
      return;
    }
    if (tool.id == 'speakers') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const SpeakersScreen()));
      return;
    }
    if (tool.id == 'name_tag') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const NameTagScreen()));
      return;
    }
    if (tool.id == 'venue') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const VenueScreen()));
      return;
    }
    if (tool.id == 'voting') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const LiveVotingScreen()));
      return;
    }
    if (tool.id == 'ask_qa') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const AskQAScreen()));
      return;
    }
    if (tool.id == 'resources') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const ResourcesScreen()));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opening ${tool.title}...',
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

            // Subtle Background Waves
            Positioned.fill(
              child: CustomPaint(painter: BackgroundPatternPainter()),
            ),

            // Main Content Area
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar (Back Button + Title aligned left + Grid Toggle pushed right)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
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
                          'Quick Access',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),

                        // Spacer to push the toggle icon to the right
                        const Spacer(),

                        // Grid / List View Toggle Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              setState(() {
                                _isGridView = !_isGridView;
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
                                _isGridView
                                    ? Icons.grid_view_rounded
                                    : Icons.view_agenda_rounded,
                                color: const Color(0xFFFDC55A),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Hero Banner Card: "Explore Congress Tools"
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
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
                          // Sparkles Squircle Badge
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
                              Icons.auto_awesome_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Text Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Explore Congress\nTools',
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
                                  'Everything you need for the full event\nexperience',
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

                          // Search Bar
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
                                        hintText: 'Search quick access',
                                        hintStyle: GoogleFonts.plusJakartaSans(
                                          color: const Color(0xFF94A3B8),
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_searchController.text.isNotEmpty)
                                    GestureDetector(
                                      onTap: () {
                                        _searchController.clear();
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.clear_rounded,
                                        color: Color(0xFF94A3B8),
                                        size: 20,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Category Filter Pills (All, Event, Interactive, Tools)
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

                          // Tool Cards Grid or List
                          Expanded(
                            child: _filteredTools.isEmpty
                                ? Center(
                                    child: Text(
                                      'No tools match your search.',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : _isGridView
                                ? _buildToolsGrid(_filteredTools)
                                : _buildToolsList(_filteredTools),
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

  // Responsive Grid of Tools
  Widget _buildToolsGrid(List<QuickAccessTool> tools) {
    final columns = context.screenWidth >= 900 ? 4 : (context.isTablet ? 3 : 2);
    final aspectRatio = context.responsiveValue(
      mobile: context.screenWidth < 360 ? 0.82 : 0.88,
      tablet: 1.05,
    );
    final hPad = context.responsiveHorizontalPadding;

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(hPad, 4, hPad, 24),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: aspectRatio,
      ),
      itemCount: tools.length,
      itemBuilder: (context, index) {
        final tool = tools[index];
        return _buildToolCard(tool);
      },
    );
  }

  // 1-Column List View of Tools (alternate view)
  Widget _buildToolsList(List<QuickAccessTool> tools) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      physics: const BouncingScrollPhysics(),
      itemCount: tools.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tool = tools[index];
        return _buildToolListTile(tool);
      },
    );
  }

  // Individual Tool Card Widget
  Widget _buildToolCard(QuickAccessTool tool) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
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
          onTap: () => _onToolTap(tool),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Squircle Icon Badge
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2B8CFF), Color(0xFF0D63E5)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0D63E5).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(tool.icon, color: Colors.white, size: 24),
                ),

                const Spacer(),

                // Title
                Text(
                  tool.title,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),

                // Description
                Text(
                  tool.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF64748B),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),

                const Spacer(),

                // Bottom Row: Category Chip + Arrow Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tool.category,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF64748B),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.primaryBlue,
                      size: 18,
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

  // Tool List Tile (when toggled to list mode)
  Widget _buildToolListTile(QuickAccessTool tool) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _onToolTap(tool),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2B8CFF), Color(0xFF0D63E5)],
                    ),
                  ),
                  child: Icon(tool.icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            tool.title,
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.textDark,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tool.category,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF64748B),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tool.description.replaceAll('\n', ' '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF64748B),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.primaryBlue,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
