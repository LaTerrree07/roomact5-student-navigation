import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lim_navigation_app/demo_auth.dart';
import 'package:lim_navigation_app/main.dart';
import 'package:lim_navigation_app/main_screen.dart';
import 'package:lim_navigation_app/profile_page.dart';
import 'package:lim_navigation_app/social_media_page.dart';

void main() {
  setUp(() {
    DemoAuth.registeredUsername = null;
    DemoAuth.registeredPassword = null;
  });

  Finder navDestination(String label) {
    return find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text(label),
    );
  }

  testWidgets('Validation error and invalid credentials snackbar on login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudentApp());

    // Tap login with empty fields -> triggers validation error text
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Enter your username.'), findsOneWidget);
    expect(find.text('Enter your password.'), findsOneWidget);

    // Enter non-matching credentials
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'unknown',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'wrongpass',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    expect(find.text('Invalid username or password.'), findsOneWidget);
  });

  testWidgets(
    'Register new account and login with newly registered credentials',
    (WidgetTester tester) async {
      await tester.pumpWidget(const StudentApp());

      // Navigate to Register screen
      await tester.tap(find.text("Don't have an account? Register"));
      await tester.pumpAndSettle();

      expect(find.text('Create an Account'), findsOneWidget);

      // Enter new user credentials
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'student1',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'password123',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'password123',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pumpAndSettle();

      // Verify redirected back to Login screen with registration success message
      expect(
        find.text('Registration successful! You can now log in.'),
        findsOneWidget,
      );
      expect(find.text('Welcome Back'), findsOneWidget);

      // Log in with newly registered account
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Username'),
        'student1',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'password123',
      );
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // Should now be on MainScreen with bottom navigation bar and Home page
      expect(find.byType(MainScreen), findsOneWidget);
      expect(find.text('Welcome, Student!'), findsOneWidget);
    },
  );

  testWidgets('Default admin credentials log into MainScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudentApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'admin',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'admin123',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.byType(MainScreen), findsOneWidget);
    expect(navDestination('Home'), findsOneWidget);
    expect(navDestination('Calculator'), findsOneWidget);
    expect(navDestination('Profile'), findsOneWidget);
    expect(navDestination('Social Media'), findsOneWidget);
  });

  testWidgets(
    'Navigation bar switches across all 4 destinations with content',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));

      // 1. Home tab active
      expect(find.text('Welcome, Student!'), findsOneWidget);

      // 2. Switch to Calculator tab
      await tester.tap(navDestination('Calculator'));
      await tester.pumpAndSettle();
      expect(find.text('BASIC CALCULATOR'), findsOneWidget);

      // 3. Switch to Profile tab
      await tester.tap(navDestination('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Earth Justin Lim'), findsOneWidget);
      expect(find.text('BS Information Technology'), findsOneWidget);
      expect(find.text('553550'), findsOneWidget);

      // 4. Switch to Social Media tab
      await tester.tap(navDestination('Social Media'));
      await tester.pumpAndSettle();
      expect(find.text('Connect With Me'), findsOneWidget);

      // Tap Facebook card and verify SnackBar
      await tester.tap(find.text('Facebook'));
      await tester.pump();
      expect(
        find.text('Selected account: Facebook: @la.terrree'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Calculator state is preserved when switching tabs using IndexedStack',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));

      // Switch to Calculator
      await tester.tap(navDestination('Calculator'));
      await tester.pumpAndSettle();

      // Enter numbers into calculator
      final firstField = find.widgetWithText(TextField, 'First Number');
      final secondField = find.widgetWithText(TextField, 'Second Number');
      await tester.enterText(firstField, '15');
      await tester.enterText(secondField, '25');

      // Tap '+' button
      await tester.tap(find.widgetWithText(ElevatedButton, '+'));
      await tester.pumpAndSettle();

      // Verify result is 40.0
      expect(find.text('40.0'), findsOneWidget);

      // Switch away to Profile tab
      await tester.tap(navDestination('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Earth Justin Lim'), findsOneWidget);

      // Switch away to Home tab
      await tester.tap(navDestination('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Welcome, Student!'), findsOneWidget);

      // Switch back to Calculator tab
      await tester.tap(navDestination('Calculator'));
      await tester.pumpAndSettle();

      // Verify inputs and result are still preserved
      expect(find.text('15'), findsOneWidget);
      expect(find.text('25'), findsOneWidget);
      expect(find.text('40.0'), findsOneWidget);
      expect(find.text('15.0 + 25.0'), findsOneWidget);
    },
  );

  testWidgets(
    'ProfilePage displays full student details, about me, and hobbies',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

      expect(find.text('Earth Justin Lim'), findsOneWidget);
      expect(find.text('BS Information Technology'), findsOneWidget);
      expect(find.text('553550'), findsOneWidget);
      expect(find.text('3rd Year — PS303'), findsOneWidget);
      expect(find.text('CCE106L'), findsOneWidget);
      expect(find.text('e.lim.553550@umindanao.edu.ph'), findsOneWidget);

      // Scroll to see About Me and Hobbies
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      expect(find.text('About Me'), findsOneWidget);
      expect(find.text('Hobbies and Interests'), findsOneWidget);
      expect(find.text('Watching movies'), findsOneWidget);
      expect(find.text('Playing badminton'), findsOneWidget);
      expect(find.text('Listening to music'), findsOneWidget);
    },
  );

  testWidgets('SocialMediaPage displays all 4 platforms and shows SnackBars', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SocialMediaPage()));

    expect(find.text('Facebook'), findsOneWidget);
    expect(find.text('Instagram'), findsOneWidget);
    expect(find.text('Threads'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('@la.terrree'), findsNWidgets(3));
    expect(find.text('@LaTerrree07'), findsOneWidget);

    // Tap Instagram
    await tester.tap(find.text('Instagram'));
    await tester.pump();
    expect(
      find.text('Selected account: Instagram: @la.terrree'),
      findsOneWidget,
    );

    // Tap GitHub
    await tester.tap(find.text('GitHub'));
    await tester.pump();
    expect(find.text('Selected account: GitHub: @LaTerrree07'), findsOneWidget);
  });
}
