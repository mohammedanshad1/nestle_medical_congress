import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../widgets/background_pattern.dart';

class PollOption {
  final String title;
  int votes;
  final Color barColor;

  PollOption({
    required this.title,
    required this.votes,
    required this.barColor,
  });
}

class LivePoll {
  final String id;
  final String category;
  final String question;
  int? userVotedIndex;
  final List<PollOption> options;

  LivePoll({
    required this.id,
    required this.category,
    required this.question,
    this.userVotedIndex,
    required this.options,
  });

  int get totalVotes => options.fold(0, (sum, opt) => sum + opt.votes);
}

class LiveVotingScreen extends StatefulWidget {
  const LiveVotingScreen({super.key});

  @override
  State<LiveVotingScreen> createState() => _LiveVotingScreenState();
}

class _LiveVotingScreenState extends State<LiveVotingScreen> {
  int _currentPollIndex = 0;

  final List<LivePoll> _polls = [
    // Poll 1 (matches screen 9.jpg)
    LivePoll(
      id: 'poll_1',
      category: 'Audience Feedback',
      question: 'How would you rate the\ncurrent session?',
      userVotedIndex: 1, // "Very Good" voted by default
      options: [
        PollOption(
          title: 'Excellent',
          votes: 55,
          barColor: const Color(0xFF38BDF8),
        ),
        PollOption(
          title: 'Very Good',
          votes: 31,
          barColor: const Color(0xFFF59E0B),
        ),
        PollOption(
          title: 'Good',
          votes: 10,
          barColor: const Color(0xFF38BDF8),
        ),
        PollOption(
          title: 'Needs Improvement',
          votes: 5,
          barColor: const Color(0xFF94A3B8),
        ),
      ],
    ),

    // Poll 2
    LivePoll(
      id: 'poll_2',
      category: 'Session Topic Interest',
      question: 'Which topic should be\nexpanded tomorrow?',
      userVotedIndex: 0,
      options: [
        PollOption(
          title: 'Pediatric Microbiome',
          votes: 42,
          barColor: const Color(0xFF38BDF8),
        ),
        PollOption(
          title: 'Infant Growth Trials',
          votes: 38,
          barColor: const Color(0xFFF59E0B),
        ),
        PollOption(
          title: 'Prebiotic Clinical Evidence',
          votes: 20,
          barColor: const Color(0xFF38BDF8),
        ),
      ],
    ),

    // Poll 3
    LivePoll(
      id: 'poll_3',
      category: 'Q&A Participation',
      question: 'Will you participate in\nthe live Q&A panel?',
      userVotedIndex: null,
      options: [
        PollOption(
          title: 'Yes, I have questions',
          votes: 62,
          barColor: const Color(0xFF38BDF8),
        ),
        PollOption(
          title: 'Maybe as an observer',
          votes: 28,
          barColor: const Color(0xFFF59E0B),
        ),
        PollOption(
          title: 'Not this session',
          votes: 10,
          barColor: const Color(0xFF94A3B8),
        ),
      ],
    ),
  ];

  void _onVoteOption(int optionIndex) {
    setState(() {
      final poll = _polls[_currentPollIndex];
      if (poll.userVotedIndex != null) {
        // Adjust vote count if changing previous vote
        poll.options[poll.userVotedIndex!].votes--;
      }
      poll.userVotedIndex = optionIndex;
      poll.options[optionIndex].votes++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Vote submitted: "${_polls[_currentPollIndex].options[optionIndex].title}"',
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

  void _nextPoll() {
    if (_currentPollIndex < _polls.length - 1) {
      setState(() {
        _currentPollIndex++;
      });
    } else {
      setState(() {
        _currentPollIndex = 0;
      });
    }
  }

  void _previousPoll() {
    if (_currentPollIndex > 0) {
      setState(() {
        _currentPollIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPoll = _polls[_currentPollIndex];
    final totalVotes = currentPoll.totalVotes;

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
              child: CustomPaint(
                painter: BackgroundPatternPainter(),
              ),
            ),

            // Content Area
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar (Back Button + "Live Voting" Title + Ballot Action)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                                color: const Color(0xFF0F2650).withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFF1E4380).withValues(alpha: 0.6),
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
                          'Live Voting',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),

                        // Ballot / History Action
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Viewing all congress live polls...',
                                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
                                  ),
                                  backgroundColor: AppColors.primaryBlue,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F2650).withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFF1E4380).withValues(alpha: 0.6),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.how_to_vote_rounded,
                                color: Color(0xFFF59E0B),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Hero Banner Card: "Audience Interaction"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                          // Warm Amber Bar Chart Icon Badge
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFFB74D),
                                  Color(0xFFF59E0B),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.bar_chart_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Text Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Audience Interaction',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Swipe polls, choose answers, and\nsubmit your vote',
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
                          const SizedBox(height: 14),

                          // Page Indicator Dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_polls.length, (index) {
                              final isCurrent = index == _currentPollIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: isCurrent ? 24 : 7,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isCurrent
                                      ? AppColors.primaryBlue
                                      : const Color(0xFFCBD5E1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 14),

                          // Scrollable Poll Content Card
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(26),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header: Category Pill & Subtitle
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // "VOTED" Badge
                                        if (currentPoll.userVotedIndex != null)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFEF3C7),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: 6,
                                                  height: 6,
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xFFF59E0B),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  'VOTED',
                                                  style: GoogleFonts.plusJakartaSans(
                                                    color: const Color(0xFFD97706),
                                                    fontSize: 10.5,
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        else
                                          const SizedBox(),

                                        Text(
                                          currentPoll.category,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF64748B),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 14),

                                    // Question Title
                                    Text(
                                      currentPoll.question,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textDark,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w800,
                                        height: 1.24,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    // Total Votes Count
                                    Text(
                                      '$totalVotes total votes',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    const SizedBox(height: 18),

                                    // Poll Option Cards List
                                    Column(
                                      children: List.generate(
                                        currentPoll.options.length,
                                        (index) {
                                          final option = currentPoll.options[index];
                                          final isSelected = currentPoll.userVotedIndex == index;
                                          final double percent = totalVotes == 0
                                              ? 0.0
                                              : (option.votes / totalVotes);
                                          final int percentInt = (percent * 100).round();

                                          return _buildOptionCard(
                                            index: index,
                                            option: option,
                                            isSelected: isSelected,
                                            percent: percent,
                                            percentInt: percentInt,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Bottom Navigation Bar: Prev Arrow, "Next Poll" Button, Next Arrow
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                            child: Row(
                              children: [
                                // Previous Button
                                _buildNavArrowButton(
                                  icon: Icons.arrow_back_rounded,
                                  onTap: _currentPollIndex > 0 ? _previousPoll : null,
                                ),
                                const SizedBox(width: 14),

                                // Next Poll Gradient Button
                                Expanded(
                                  child: Container(
                                    height: 52,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFF38BDF8),
                                          Color(0xFF0D6BF5),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF0D6BF5).withValues(alpha: 0.35),
                                          blurRadius: 14,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(26),
                                        onTap: _nextPoll,
                                        child: Center(
                                          child: Text(
                                            'Next Poll',
                                            style: GoogleFonts.plusJakartaSans(
                                              color: Colors.white,
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Next Button
                                _buildNavArrowButton(
                                  icon: Icons.arrow_forward_rounded,
                                  onTap: _nextPoll,
                                ),
                              ],
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

  // Option Card
  Widget _buildOptionCard({
    required int index,
    required PollOption option,
    required bool isSelected,
    required double percent,
    required int percentInt,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? AppColors.primaryBlue
              : const Color(0xFFE2E8F0),
          width: isSelected ? 1.8 : 1.2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _onVoteOption(index),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Radio Check + Option Title + Percentage
                Row(
                  children: [
                    // Radio Checkbox Indicator
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.primaryBlue
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : const Color(0xFFCBD5E1),
                          width: 1.5,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 15,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),

                    // Option Title
                    Expanded(
                      child: Text(
                        option.title,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textDark,
                          fontSize: 14.5,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                        ),
                      ),
                    ),

                    // Percentage
                    Text(
                      '$percentInt%',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.primaryBlue,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: percent,
                    minHeight: 5,
                    backgroundColor: const Color(0xFFF1F5F9),
                    valueColor: AlwaysStoppedAnimation<Color>(option.barColor),
                  ),
                ),

                const SizedBox(height: 6),

                // Vote Count
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${option.votes} votes',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF94A3B8),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
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

  Widget _buildNavArrowButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    final bool isEnabled = onTap != null;

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Icon(
            icon,
            color: isEnabled ? AppColors.textDark : const Color(0xFFCBD5E1),
            size: 20,
          ),
        ),
      ),
    );
  }
}

