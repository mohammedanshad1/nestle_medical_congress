import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestle_medical_congress/main.dart';
import 'package:nestle_medical_congress/screens/home_screen.dart';
import 'package:nestle_medical_congress/screens/quick_access_screen.dart';

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

    // Verify Title & Hero
    expect(find.text('Quick Access'), findsOneWidget);
    expect(find.text('Explore Congress\nTools'), findsOneWidget);
    expect(find.text('Search quick access'), findsOneWidget);

    // Verify Category Pills
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Event'), findsWidgets);
    expect(find.text('Interactive'), findsWidgets);
    expect(find.text('Tools'), findsWidgets);

    // Verify Tool Cards
    expect(find.text('Agenda'), findsOneWidget);
    expect(find.text('Speakers'), findsOneWidget);
    expect(find.text('Name Tag'), findsOneWidget);
    expect(find.text('Venue'), findsOneWidget);
  });
}
