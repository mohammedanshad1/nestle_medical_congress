import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestle_medical_congress/main.dart';
import 'package:nestle_medical_congress/screens/agenda_screen.dart';
import 'package:nestle_medical_congress/screens/ask_qa_screen.dart';
import 'package:nestle_medical_congress/screens/home_screen.dart';
import 'package:nestle_medical_congress/screens/live_voting_screen.dart';
import 'package:nestle_medical_congress/screens/login_screen.dart';
import 'package:nestle_medical_congress/screens/name_tag_screen.dart';
import 'package:nestle_medical_congress/screens/profile_screen.dart';
import 'package:nestle_medical_congress/screens/quick_access_screen.dart';
import 'package:nestle_medical_congress/screens/register_screen.dart';
import 'package:nestle_medical_congress/screens/resources_screen.dart';
import 'package:nestle_medical_congress/screens/speakers_screen.dart';
import 'package:nestle_medical_congress/screens/splash_screen.dart';
import 'package:nestle_medical_congress/screens/venue_screen.dart';

void main() {
  testWidgets('Tapping Sign In on LoginScreen navigates directly to HomeScreen without validation', (WidgetTester tester) async {
    await tester.pumpWidget(const NestleCongressApp());
    await tester.pumpAndSettle();

    expect(find.text('Sign In'), findsOneWidget);

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back,\nDr. Testing 👋'), findsOneWidget);
    expect(find.text('Quick Access'), findsOneWidget);
  });

  testWidgets('Nestle Medical Congress Home Screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NESTLÉ MEDICAL CONGRESS'), findsOneWidget);
    expect(find.text('Welcome Back,\nDr. Testing 👋'), findsOneWidget);
    expect(find.text('FEATURED EVENT'), findsOneWidget);
    expect(find.text('Agenda'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Tap Profile tab in bottom nav bar
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Huda Latheef'), findsOneWidget);
    expect(find.text('ID: NMC-2026-001'), findsOneWidget);

    // Tap Home tab to return
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back,\nDr. Testing 👋'), findsOneWidget);
  });

  testWidgets('QuickAccessScreen (Screen 4) smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: QuickAccessScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Quick Access'), findsOneWidget);
    expect(find.text('Explore Congress\nTools'), findsOneWidget);
    expect(find.text('Search quick access'), findsOneWidget);

    expect(find.text('All'), findsOneWidget);
    expect(find.text('Event'), findsWidgets);
    expect(find.text('Interactive'), findsWidgets);
    expect(find.text('Tools'), findsWidgets);

    expect(find.text('Agenda'), findsOneWidget);
    expect(find.text('Speakers'), findsOneWidget);
    expect(find.text('Name Tag'), findsOneWidget);
    expect(find.text('Venue'), findsOneWidget);
  });

  testWidgets('AgendaScreen (Screen 5) smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AgendaScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Congress Agenda'), findsOneWidget);
    expect(find.text('Day 1 Schedule'), findsOneWidget);
    expect(find.text('Thursday, May 22, 2026'), findsOneWidget);

    expect(find.text('Day 1'), findsOneWidget);
    expect(find.text('May 22'), findsOneWidget);
    expect(find.text('Day 2'), findsOneWidget);
    expect(find.text('May 23'), findsOneWidget);

    expect(find.text("Today's Sessions"), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);

    expect(find.text('All'), findsOneWidget);
    expect(find.text('Keynote'), findsWidgets);
    expect(find.text('Nutrition'), findsWidgets);
    expect(find.text('Research'), findsWidgets);

    expect(find.text('Opening Ceremony'), findsOneWidget);
    expect(find.text('Welcome &\nIntroduction'), findsOneWidget);
    expect(find.text('Future of Pediatric\nNutrition'), findsOneWidget);

    await tester.tap(find.text('Day 2'));
    await tester.pumpAndSettle();

    expect(find.text('Day 2 Schedule'), findsOneWidget);
    expect(find.text('Friday, May 23, 2026'), findsOneWidget);
  });

  testWidgets('SpeakersScreen (Screen 6) smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: SpeakersScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Speakers'), findsOneWidget);
    expect(find.text('Global Medical\nExperts'), findsOneWidget);
    expect(find.text('Search speakers'), findsOneWidget);

    expect(find.text('All'), findsOneWidget);
    expect(find.text('Nutrition'), findsWidgets);
    expect(find.text('Research'), findsWidgets);
    expect(find.text('Pediatrics'), findsWidgets);
    expect(find.text('Clinical'), findsWidgets);

    expect(find.text('FEATURED SPEAKER'), findsOneWidget);
    expect(find.text('Dr. Sarah Johnson'), findsOneWidget);
    expect(find.text('Dr. Hassan Ali'), findsOneWidget);

    await tester.tap(find.text('Dr. Sarah Johnson'));
    await tester.pumpAndSettle();

    expect(find.text('Biography'), findsOneWidget);
  });

  testWidgets('NameTagScreen (Screen 7) smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: NameTagScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Name Tag'), findsOneWidget);
    expect(find.text('NESTLÉ MEDICAL'), findsOneWidget);
    expect(find.text('CONGRESS 2026'), findsOneWidget);
    expect(find.text('HL'), findsOneWidget);
    expect(find.text('Huda Latheef'), findsOneWidget);
    expect(find.text('Flutter Developer • Attendee'), findsOneWidget);
    expect(find.text('Badge ID'), findsOneWidget);
    expect(find.text('NMC-2026-001'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('Dubai, UAE'), findsOneWidget);
    expect(find.text('Congress Date'), findsOneWidget);
    expect(find.text('22 - 23 May 2026'), findsOneWidget);
  });

  testWidgets('VenueScreen (Screen 8) smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: VenueScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Venue'), findsOneWidget);
    expect(find.text('Dubai International\nConvention & Exhibition\nCenter'), findsOneWidget);
    expect(find.text('22 - 23 May 2026'), findsOneWidget);
    expect(find.text('Venue Address'), findsOneWidget);
    expect(find.text('World Trade Centre, Dubai,\nUnited Arab Emirates'), findsOneWidget);
    expect(find.text('Map Preview'), findsOneWidget);
    expect(find.text('Venue Facilities'), findsOneWidget);
    expect(find.text('Free Wi-Fi'), findsOneWidget);
    expect(find.text('Parking'), findsOneWidget);
    expect(find.text('Catering'), findsOneWidget);
    expect(find.text('Accessible'), findsOneWidget);
  });

  testWidgets('LiveVotingScreen (Screen 9) smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: LiveVotingScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Live Voting'), findsOneWidget);
    expect(find.text('Audience Interaction'), findsOneWidget);
    expect(find.text('VOTED'), findsOneWidget);
    expect(find.text('Audience Feedback'), findsOneWidget);
    expect(find.text('How would you rate the\ncurrent session?'), findsOneWidget);
    expect(find.text('Excellent'), findsOneWidget);
    expect(find.text('Very Good'), findsOneWidget);
    expect(find.text('Good'), findsOneWidget);
    expect(find.text('Needs Improvement'), findsOneWidget);
    expect(find.text('Next Poll'), findsOneWidget);

    // Tap Next Poll to switch polls
    await tester.tap(find.text('Next Poll'));
    await tester.pumpAndSettle();

    expect(find.text('Which topic should be\nexpanded tomorrow?'), findsOneWidget);

    // Vote on an option in this poll
    await tester.tap(find.text('Pediatric Microbiome'));
    await tester.pumpAndSettle();
  });

  testWidgets('AskQAScreen (Screen 10) smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: AskQAScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ask Q&A'), findsOneWidget);
    expect(find.text('Ask the Experts'), findsOneWidget);
    expect(find.text('Write your question'), findsOneWidget);
    expect(find.text('Submit Question'), findsOneWidget);

    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Recent'), findsOneWidget);
    expect(find.text('Answered'), findsWidgets);

    expect(find.text('How can pediatric nutrition plans be personalized for children with different growth patterns?'), findsOneWidget);
    expect(find.text('Dr. Ahmed'), findsOneWidget);
    expect(find.text('24'), findsOneWidget);
  });

  testWidgets('ResourcesScreen (Screen 11) smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: ResourcesScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // App Bar & Hero Card
    expect(find.text('Resources'), findsOneWidget);
    expect(find.text('Congress Library'), findsOneWidget);
    expect(find.text('Access presentations, documents and media files'), findsOneWidget);

    // Search input
    expect(find.text('Search resources'), findsOneWidget);

    // Category pills
    expect(find.text('All'), findsOneWidget);
    expect(find.text('PDF'), findsWidgets);
    expect(find.text('Slides'), findsWidgets);
    expect(find.text('Videos'), findsWidgets);
    expect(find.text('Saved'), findsWidgets);

    // Initial items visible
    expect(find.text('Congress Scientific Prog...'), findsOneWidget);
    expect(find.text('Complete schedule and session de...'), findsOneWidget);
    expect(find.text('4.2 MB'), findsOneWidget);

    expect(find.text('Pediatric Nutrition Guide...'), findsOneWidget);
    expect(find.text('Clinical reference material'), findsOneWidget);
    expect(find.text('2.8 MB'), findsOneWidget);

    expect(find.text('Keynote Presentation Sli...'), findsOneWidget);
    expect(find.text('The Next Era of Nutrition & Health'), findsOneWidget);
    expect(find.text('8.6 MB'), findsOneWidget);

    // Filter by Slides
    await tester.tap(find.text('Slides').first);
    await tester.pumpAndSettle();

    expect(find.text('Keynote Presentation Sli...'), findsOneWidget);
    expect(find.text('Congress Scientific Prog...'), findsNothing);

    // Filter by PDF
    await tester.tap(find.text('PDF').first);
    await tester.pumpAndSettle();

    expect(find.text('Congress Scientific Prog...'), findsOneWidget);
    expect(find.text('Pediatric Nutrition Guide...'), findsOneWidget);
    expect(find.text('Keynote Presentation Sli...'), findsNothing);

    // Search functionality
    await tester.enterText(find.byType(TextField), 'Pediatric');
    await tester.pumpAndSettle();

    expect(find.text('Pediatric Nutrition Guide...'), findsOneWidget);
    expect(find.text('Congress Scientific Prog...'), findsNothing);

    // Clear search and reset to All
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();

    expect(find.text('Congress Scientific Prog...'), findsOneWidget);
  });

  testWidgets('SplashScreen smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(autoNavigate: false),
      ),
    );
    await tester.pump();

    expect(find.text('NESTLÉ HEALTH SCIENCE'), findsOneWidget);
    expect(find.text('NESTLÉ MEDICAL\nCONGRESS'), findsOneWidget);
    expect(find.text('ANNUAL GLOBAL EDITION 2026'), findsOneWidget);
    expect(find.text('The Next Era of Nutrition & Health'), findsOneWidget);
    expect(find.text('Vienna • May 22–23, 2026'), findsOneWidget);
    expect(find.text('Tap anywhere to continue →'), findsOneWidget);
  });

  testWidgets('Responsive layout small mobile LoginScreen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('NESTLÉ MEDICAL CONGRESS'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Responsive layout small mobile RegisterScreen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: RegisterScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Join the'), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
  });

  testWidgets('Responsive layout small mobile HomeScreen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Quick Access'), findsOneWidget);
  });

  testWidgets('Responsive layouts on tablet screen (768x1024)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    // Test QuickAccessScreen on tablet
    await tester.pumpWidget(
      const MaterialApp(
        home: QuickAccessScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Quick Access'), findsOneWidget);
    expect(find.text('Agenda'), findsOneWidget);

    // Test ProfileScreen on tablet
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Huda Latheef'), findsOneWidget);
  });
}
