import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestle_medical_congress/main.dart';
import 'package:nestle_medical_congress/screens/home_screen.dart';

void main() {
  testWidgets('Nestle Medical Congress login screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NestleCongressApp());
    await tester.pumpAndSettle();

    expect(find.text('NESTLÉ'), findsOneWidget);
    expect(find.text('CONGRESS'), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Nestle Medical Congress Home Screen (Screen 3) smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Header
    expect(find.text('NESTLÉ MEDICAL CONGRESS'), findsOneWidget);
    expect(find.text('Welcome Back,\nDr. Testing 👋'), findsOneWidget);

    // Verify Search hint
    expect(find.text('Search sessions, speakers, topi...'), findsOneWidget);

    // Verify Featured Event
    expect(find.text('FEATURED EVENT'), findsOneWidget);
    expect(find.text('The Next Era of\nNutrition & Health'), findsOneWidget);

    // Verify Quick Access Tools
    expect(find.text('Quick Access'), findsOneWidget);
    expect(find.text('Agenda'), findsOneWidget);
    expect(find.text('Speakers'), findsOneWidget);
    expect(find.text('Name Tag'), findsOneWidget);
    expect(find.text('Venue'), findsOneWidget);
    expect(find.text('Voting'), findsOneWidget);
    expect(find.text('Ask Q&A'), findsOneWidget);
    expect(find.text('Resources'), findsOneWidget);
    expect(find.text('Exhibitors'), findsOneWidget);

    // Verify Upcoming Sessions
    expect(find.text('Upcoming Sessions'), findsOneWidget);
    expect(find.text('Opening Ceremony'), findsOneWidget);

    // Verify Bottom Navigation Bar
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
