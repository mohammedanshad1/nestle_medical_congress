import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestle_medical_congress/main.dart';
import 'package:nestle_medical_congress/screens/agenda_screen.dart';
import 'package:nestle_medical_congress/screens/home_screen.dart';
import 'package:nestle_medical_congress/screens/name_tag_screen.dart';
import 'package:nestle_medical_congress/screens/quick_access_screen.dart';
import 'package:nestle_medical_congress/screens/speakers_screen.dart';
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
}
