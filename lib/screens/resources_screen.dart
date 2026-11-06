import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/background_pattern.dart';

/// Model representing a downloadable congress library resource
class ResourceItem {
  final String id;
  final String title;
  final String subtitle;
  final String category; // 'PDF', 'Slides', 'Videos'
  final Color categoryColor;
  final String fileSize;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String description;
  final String author;
  final String publishDate;
  bool isBookmarked;
  bool isDownloaded;

  ResourceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.categoryColor,
    required this.fileSize,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.description,
    required this.author,
    required this.publishDate,
    this.isBookmarked = false,
    this.isDownloaded = false,
  });
}

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<String> _categories = const [
    'All',
    'PDF',
    'Slides',
    'Videos',
    'Saved',
  ];

  late final List<ResourceItem> _resources = [
    ResourceItem(
      id: 'res_1',
      title: 'Congress Scientific Prog...',
      subtitle: 'Complete schedule and session de...',
      category: 'PDF',
      categoryColor: const Color(0xFFEF4444),
      fileSize: '4.2 MB',
      icon: Icons.picture_as_pdf_rounded,
      iconColor: const Color(0xFFEF4444),
      iconBgColor: const Color(0xFFFEE2E2),
      description:
          'Comprehensive official congress scientific programme, abstract collection, speaker biographies, and session schedules for all conference days.',
      author: 'Scientific Committee',
      publishDate: 'May 2026',
    ),
    ResourceItem(
      id: 'res_2',
      title: 'Pediatric Nutrition Guide...',
      subtitle: 'Clinical reference material',
      category: 'PDF',
      categoryColor: const Color(0xFF2563EB),
      fileSize: '2.8 MB',
      icon: Icons.menu_book_rounded,
      iconColor: const Color(0xFF2563EB),
      iconBgColor: const Color(0xFFDBEAFE),
      description:
          'Updated clinical guidelines on early infant and toddler nutrition, micro-nutrient intake standards, and dietary allergy management.',
      author: 'Prof. Dr. Sarah Jenkins & Clinical Board',
      publishDate: 'May 2026',
    ),
    ResourceItem(
      id: 'res_3',
      title: 'Keynote Presentation Sli...',
      subtitle: 'The Next Era of Nutrition & Health',
      category: 'Slides',
      categoryColor: const Color(0xFFF59E0B),
      fileSize: '8.6 MB',
      icon: Icons.slideshow_rounded,
      iconColor: const Color(0xFFF59E0B),
      iconBgColor: const Color(0xFFFEF3C7),
      description:
          'Full slide deck from the opening keynote session discussing microbiome advancements, bio-fortified formulations, and global healthcare trends.',
      author: 'Dr. Michael Chen & Nestlé Research',
      publishDate: 'May 2026',
    ),
    ResourceItem(
      id: 'res_4',
      title: 'Infant Microbiome Lecture Video',
      subtitle: 'Prof. Dr. Sarah Jenkins Keynote Recording',
      category: 'Videos',
      categoryColor: const Color(0xFF8B5CF6),
      fileSize: '34.5 MB',
      icon: Icons.play_circle_outline_rounded,
      iconColor: const Color(0xFF8B5CF6),
      iconBgColor: const Color(0xFFF3E8FF),
      description:
          'High-definition full video recording of the keynote plenary lecture exploring gut microbiota colonization in early life.',
      author: 'Nestlé Medical Media Team',
      publishDate: 'May 2026',
    ),
    ResourceItem(
      id: 'res_5',
      title: 'Clinical Research Whitepaper',
      subtitle: 'Maternal nutrition & neonatal outcomes',
      category: 'PDF',
      categoryColor: const Color(0xFF10B981),
      fileSize: '5.1 MB',
      icon: Icons.description_rounded,
      iconColor: const Color(0xFF10B981),
      iconBgColor: const Color(0xFFD1FAE5),
      description:
          'Peer-reviewed whitepaper detailing longitudinal health outcomes from maternal nutritional supplementation across multi-center trials.',
      author: 'Nestlé Health Science Editorial',
      publishDate: 'May 2026',
    ),
    ResourceItem(
      id: 'res_6',
      title: 'Workshop Slide Deck: Gut-Brain Axis',
      subtitle: 'Interactive seminar presentation & cases',
      category: 'Slides',
      categoryColor: const Color(0xFF06B6D4),
      fileSize: '12.4 MB',
      icon: Icons.co_present_rounded,
      iconColor: const Color(0xFF06B6D4),
      iconBgColor: const Color(0xFFCFFAFE),
      description:
          'Workshop slides featuring clinical case studies on the enteric nervous system, probiotic formulations, and cognitive development in young children.',
      author: 'Dr. Elena Rostova',
      publishDate: 'May 2026',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ResourceItem> get _filteredResources {
    final query = _searchController.text.trim().toLowerCase();

    return _resources.where((item) {
      // Category filter
      final matchesCategory = switch (_selectedCategory) {
        'All' => true,
        'Saved' => item.isBookmarked,
        _ => item.category.toLowerCase() == _selectedCategory.toLowerCase(),
      };

      // Search query
      final matchesQuery = query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _toggleBookmark(ResourceItem item) {
    setState(() {
      item.isBookmarked = !item.isBookmarked;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          item.isBookmarked
              ? 'Saved "${item.title}" to bookmarks'
              : 'Removed "${item.title}" from bookmarks',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
        ),
        backgroundColor:
            item.isBookmarked ? const Color(0xFFF59E0B) : AppColors.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _downloadItem(ResourceItem item) {
    if (item.isDownloaded) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${item.title} is already stored in offline files',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    setState(() {
      item.isDownloaded = true;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Downloaded ${item.title} (${item.fileSize})',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showResourceDetails(ResourceItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
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
              // Sheet Grab Handle
              Center(
                child: Container(
                  width: 44,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: item.iconBgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: _buildItemBadgeIcon(item),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: item.categoryColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.category.toUpperCase(),
                            style: GoogleFonts.plusJakartaSans(
                              color: item.categoryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.title,
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              const Divider(color: Color(0xFFF1F5F9), thickness: 1.5),
              const SizedBox(height: 14),

              // Details metadata
              _buildDetailRow(
                icon: Icons.person_outline_rounded,
                label: 'Author',
                value: item.author,
              ),
              const SizedBox(height: 10),
              _buildDetailRow(
                icon: Icons.calendar_today_outlined,
                label: 'Published',
                value: item.publishDate,
              ),
              const SizedBox(height: 10),
              _buildDetailRow(
                icon: Icons.insert_drive_file_outlined,
                label: 'File Size',
                value: item.fileSize,
              ),

              const SizedBox(height: 16),
              Text(
                'Description',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.description,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF64748B),
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _downloadItem(item);
                      },
                      icon: Icon(
                        item.isDownloaded
                            ? Icons.open_in_new_rounded
                            : Icons.download_rounded,
                        size: 20,
                      ),
                      label: Text(
                        item.isDownloaded ? 'Open File' : 'Download Now',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F5F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () {
                      _toggleBookmark(item);
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      item.isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_outline_rounded,
                      color: item.isBookmarked
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF94A3B8),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.textDark,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildItemBadgeIcon(ResourceItem item) {
    if (item.category == 'PDF') {
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            item.icon,
            color: item.iconColor,
            size: 30,
          ),
        ],
      );
    }
    return Icon(
      item.icon,
      color: item.iconColor,
      size: 28,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredResources;

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

            // Background Curves Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: BackgroundPatternPainter(),
              ),
            ),

            // Main Layout
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar (Back Button + Title + Folder Action)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color: const Color(0xFF0F2650)
                                    .withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFF1E4380)
                                      .withValues(alpha: 0.6),
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

                        // Title
                        Text(
                          'Resources',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),

                        // Folder / Saved Bookmark Action Icon
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              setState(() {
                                if (_selectedCategory == 'Saved') {
                                  _selectedCategory = 'All';
                                } else {
                                  _selectedCategory = 'Saved';
                                }
                              });
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F2650)
                                    .withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFF1E4380)
                                      .withValues(alpha: 0.6),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                _selectedCategory == 'Saved'
                                    ? Icons.folder_rounded
                                    : Icons.folder_outlined,
                                color: const Color(0xFFF59E0B),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Hero Banner Card: "Congress Library"
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.responsiveHorizontalPadding, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F2650).withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              const Color(0xFF1E4380).withValues(alpha: 0.55),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Gradient Blue Squircle with Cloud Download Icon
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF38BDF8), Color(0xFF0D6BF5)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0D6BF5)
                                      .withValues(alpha: 0.35),
                                  blurRadius: 14,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.cloud_download_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Congress Library',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Access presentations, documents and media files',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(0xFF94A3B8),
                                    fontSize: 13,
                                    height: 1.35,
                                    fontWeight: FontWeight.w500,
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

                  // Main White Content Sheet Container
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          // Search Bar ("Search resources")
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(26),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.2,
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                      onChanged: (val) => setState(() {}),
                                      style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textDark,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Search resources',
                                        hintStyle: GoogleFonts.plusJakartaSans(
                                          color: const Color(0xFF94A3B8),
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
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
                                        Icons.close_rounded,
                                        color: Color(0xFF94A3B8),
                                        size: 20,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Horizontal Filter Pills (All, PDF, Slides, Videos, Saved)
                          SizedBox(
                            height: 38,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primaryBlue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                      border: isSelected
                                          ? null
                                          : Border.all(
                                              color: const Color(0xFFE2E8F0),
                                              width: 1.2,
                                            ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: AppColors.primaryBlue
                                                    .withValues(alpha: 0.28),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        category,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF64748B),
                                          fontSize: 13.5,
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

                          // Resource Cards List
                          Expanded(
                            child: filteredList.isEmpty
                                ? _buildEmptyState()
                                : ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 4, 20, 24),
                                    itemCount: filteredList.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 14),
                                    itemBuilder: (context, index) {
                                      final item = filteredList[index];
                                      return _buildResourceCard(item);
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

  // Single Resource Item Card
  Widget _buildResourceCard(ResourceItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => _showResourceDetails(item),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Leading Squircle Badge
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: item.iconBgColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: _buildItemBadgeIcon(item),
                  ),
                ),

                const SizedBox(width: 14),

                // Middle Text Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Category Tag
                      Text(
                        item.category.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          color: item.categoryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Title
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF0F172A),
                          fontSize: 15.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Subtitle
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF64748B),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // File Size with 3-lines icon
                      Row(
                        children: [
                          const Icon(
                            Icons.menu_rounded,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            item.fileSize,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF94A3B8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (item.isDownloaded) ...[
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'OFFLINE',
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFF059669),
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // Trailing Action Buttons (Bookmark on top, Download on bottom)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Bookmark Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => _toggleBookmark(item),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            item.isBookmarked
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_outline_rounded,
                            color: item.isBookmarked
                                ? const Color(0xFFF59E0B)
                                : const Color(0xFF94A3B8),
                            size: 22,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Download Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => _downloadItem(item),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            item.isDownloaded
                                ? Icons.check_circle_rounded
                                : Icons.download_rounded,
                            color: item.isDownloaded
                                ? const Color(0xFF10B981)
                                : const Color(0xFF64748B),
                            size: 22,
                          ),
                        ),
                      ),
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

  // Empty State when no resources match
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.folder_open_rounded,
                size: 36,
                color: Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No Resources Found',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.textDark,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _selectedCategory == 'Saved'
                  ? 'You haven\'t bookmarked any resources yet. Tap the bookmark icon on any document to save it here.'
                  : 'No materials match your current search or category filter. Try clearing your filters.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF64748B),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _selectedCategory = 'All';
                });
              },
              child: Text(
                'Show All Resources',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

