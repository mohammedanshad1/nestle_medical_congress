import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nestle_medical_congress/main.dart';
import 'package:nestle_medical_congress/screens/home_screen.dart';

void main() {
  testWidgets('Tapping Sign In on LoginScreen navigates directly to HomeScreen without validation', (WidgetTester tester) async {
    await tester.pumpWidget(const NestleCongressApp());
    await tester.pumpAndSettle();

    // Verify on Login screen
    expect(find.text('Sign In'), findsOneWidget);

    // Tap "Sign In" directly without filling any fields
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify it navigated to HomeScreen
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
}
