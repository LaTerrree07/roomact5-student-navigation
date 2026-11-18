import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lim_navigation_app/calculator_screen.dart';
import 'package:lim_navigation_app/dashboard_page.dart';
import 'package:lim_navigation_app/demo_auth.dart';
import 'package:lim_navigation_app/login_screen.dart';
import 'package:lim_navigation_app/main.dart';
import 'package:lim_navigation_app/main_screen.dart';
import 'package:lim_navigation_app/profile_page.dart';
import 'package:lim_navigation_app/social_media/social_media.dart';
import 'package:lim_navigation_app/social_media_page.dart' as links;

void main() {
  setUp(() {
    DemoAuth.registeredUsername = null;
    DemoAuth.registeredPassword = null;
    DemoAuth.currentUser = null;
    DemoAuth.currentUsername = null;
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

      // Verify refined text and navigate to Register screen via clickable Register action
      expect(find.text("Don't have an account? "), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, 'Register'));
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

      // Should now be on MainScreen with bottom navigation bar and Dashboard page
      expect(find.byType(MainScreen), findsOneWidget);
      expect(find.byType(DashboardPage), findsOneWidget);
      expect(find.text('Welcome, student1!'), findsOneWidget);
      expect(DemoAuth.currentUser, 'student1');
      expect(DemoAuth.currentUsername, 'student1');
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
    expect(find.byType(DashboardPage), findsOneWidget);
    expect(find.text('Welcome, admin!'), findsOneWidget);
    expect(navDestination('Dashboard'), findsOneWidget);
    expect(navDestination('Calculator'), findsOneWidget);
    expect(navDestination('Social'), findsOneWidget);
    expect(navDestination('Profile'), findsOneWidget);
    expect(DemoAuth.currentUser, 'admin');
    expect(DemoAuth.currentUsername, 'admin');
  });

  testWidgets(
    'Navigation bar switches across all 4 destinations: Dashboard, Calculator, Social, Profile',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));

      // 1. Dashboard tab active
      expect(find.text('Welcome, Student!'), findsOneWidget);
      expect(find.text('Application Overview'), findsOneWidget);

      // 2. Switch to Calculator tab (index 1)
      await tester.tap(navDestination('Calculator'));
      await tester.pumpAndSettle();
      expect(find.text('BASIC CALCULATOR'), findsOneWidget);

      // 3. Switch to Social tab (index 2)
      await tester.tap(navDestination('Social'));
      await tester.pumpAndSettle();
      expect(find.text('Social Media Feed'), findsOneWidget);
      expect(find.text('JohnDoe'), findsOneWidget);
      final feedList = find.descendant(
        of: find.byType(SocialMediaPage),
        matching: find.byType(ListView),
      );
      await tester.drag(feedList, const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(find.text('JaneSmith'), findsOneWidget);

      // 4. Switch to Profile tab (index 3)
      await tester.tap(navDestination('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Earth Justin Lim'), findsOneWidget);
      expect(find.text('BS Information Technology'), findsOneWidget);
      expect(find.text('Logged in as: Student'), findsOneWidget);
      expect(find.text('553550'), findsOneWidget);
      expect(find.text('3rd Year (3447)'), findsOneWidget);
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

      // Switch away to Dashboard tab
      await tester.tap(navDestination('Dashboard'));
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

  testWidgets('Calculator checkpoint tests: operations 20 and 5 (+, -, *, /)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: CalculatorScreen()));

    final firstField = find.widgetWithText(TextField, 'First Number');
    final secondField = find.widgetWithText(TextField, 'Second Number');
    await tester.enterText(firstField, '20');
    await tester.enterText(secondField, '5');

    // 1. Addition (20 + 5 = 25.0)
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pumpAndSettle();
    expect(find.text('25.0'), findsOneWidget);

    // 2. Subtraction (20 - 5 = 15.0)
    await tester.tap(find.widgetWithText(ElevatedButton, '−'));
    await tester.pumpAndSettle();
    expect(find.text('15.0'), findsOneWidget);

    // 3. Multiplication (20 * 5 = 100.0)
    await tester.tap(find.widgetWithText(ElevatedButton, '×'));
    await tester.pumpAndSettle();
    expect(find.text('100.0'), findsOneWidget);

    // 4. Division (20 / 5 = 4.0)
    await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
    await tester.pumpAndSettle();
    expect(find.text('4.0'), findsOneWidget);
  });

  testWidgets(
    'ProfilePage displays full student details, logged-in user, about me, and hobbies',
    (WidgetTester tester) async {
      DemoAuth.currentUsername = 'earthLim';
      await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

      expect(find.text('Earth Justin Lim'), findsOneWidget);
      expect(find.text('BS Information Technology'), findsOneWidget);
      expect(find.text('Logged in as: earthLim'), findsOneWidget);
      expect(find.text('553550'), findsOneWidget);
      expect(find.text('Year / Code'), findsOneWidget);
      expect(find.text('3rd Year (3447)'), findsOneWidget);
      expect(find.text('CCE106L'), findsOneWidget);
      expect(find.text('e.lim.553550@umindanao.edu.ph'), findsOneWidget);

      // Scroll to see About Me and Hobbies
      await tester.drag(find.byType(ListView), const Offset(0, -600));
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
    await tester.pumpWidget(const MaterialApp(home: links.SocialMediaPage()));

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

  testWidgets(
    'Social Media Feed liking, unliking, and commenting work properly',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SocialMediaPage()));

      expect(find.text('JohnDoe'), findsOneWidget);
      expect(find.text('Enjoying the sunny weather!'), findsOneWidget);

      // Tap Like on first post
      await tester.tap(find.byTooltip('Like').first);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(find.byTooltip('Unlike'), findsOneWidget);

      // Tap Unlike
      await tester.tap(find.byTooltip('Unlike'));
      await tester.pump();

      expect(find.text('1'), findsNothing);

      // Add a comment
      final commentField = find
          .widgetWithText(TextField, 'Add a comment...')
          .first;
      await tester.ensureVisible(commentField);
      await tester.enterText(commentField, 'Awesome post from a classmate!');
      await tester.ensureVisible(find.byTooltip('Post comment').first);
      await tester.tap(find.byTooltip('Post comment').first);
      await tester.pump();

      expect(
        find.textContaining('Awesome post from a classmate!'),
        findsOneWidget,
      );
      expect(find.text('1'), findsOneWidget);

      // Verify JaneSmith exists in list
      final feedList = find.descendant(
        of: find.byType(SocialMediaPage),
        matching: find.byType(ListView),
      );
      await tester.drag(feedList, const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(find.text('JaneSmith'), findsOneWidget);
      expect(find.text('Just finished a great book!'), findsOneWidget);
    },
  );

  testWidgets(
    'Creating a post validates fields and posts under current username',
    (WidgetTester tester) async {
      DemoAuth.currentUsername = 'testerUser';
      await tester.pumpWidget(const MaterialApp(home: SocialMediaPage()));

      // Open Create Post Sheet
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Create New Post'), findsOneWidget);
      expect(find.text('Posting as @testerUser'), findsOneWidget);

      final shareButton = find.widgetWithText(ElevatedButton, 'Share Post');
      final imageUrlFinder = find.byKey(const Key('post_image_url_field'));
      final captionFinder = find.byKey(const Key('post_caption_field'));

      // Attempt to submit empty form
      await tester.ensureVisible(shareButton);
      await tester.tap(shareButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter an image URL.'), findsOneWidget);
      expect(find.text('Please enter a caption.'), findsOneWidget);

      // Enter invalid image URL
      await tester.enterText(imageUrlFinder, 'invalid-url');
      await tester.ensureVisible(shareButton);
      await tester.tap(shareButton);
      await tester.pumpAndSettle();

      expect(
        find.text('Please enter a valid HTTP/HTTPS image URL.'),
        findsOneWidget,
      );

      // Enter valid image URL and caption
      await tester.enterText(
        imageUrlFinder,
        'https://picsum.photos/id/50/600/400',
      );
      await tester.enterText(
        captionFinder,
        'My first campus project showcase!',
      );

      await tester.ensureVisible(shareButton);
      await tester.tap(shareButton);
      await tester.pumpAndSettle();

      // Verify post is now at top of feed
      expect(find.text('testerUser'), findsOneWidget);
      expect(
        find.textContaining('My first campus project showcase!'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Social Media state (posts, likes, comments) is preserved in IndexedStack',
    (WidgetTester tester) async {
      DemoAuth.currentUsername = 'persistentStudent';
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));

      // Switch to Social tab
      await tester.tap(navDestination('Social'));
      await tester.pumpAndSettle();

      // Like JohnDoe's post
      await tester.tap(find.byTooltip('Like').first);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      // Scroll slightly up so comment bar is safely away from bottom navigation bar
      final feedList = find.descendant(
        of: find.byType(SocialMediaPage),
        matching: find.byType(ListView),
      );
      await tester.drag(feedList, const Offset(0, -150));
      await tester.pumpAndSettle();

      // Add a comment
      final commentField = find
          .widgetWithText(TextField, 'Add a comment...')
          .first;
      await tester.enterText(commentField, 'IndexedStack persistence check');
      await tester.tap(find.byTooltip('Post comment').first);
      await tester.pump();
      expect(
        find.textContaining('IndexedStack persistence check'),
        findsOneWidget,
      );

      // Switch away to Dashboard tab
      await tester.tap(navDestination('Dashboard'));
      await tester.pumpAndSettle();
      expect(find.text('Welcome, persistentStudent!'), findsOneWidget);

      // Switch back to Social tab
      await tester.tap(navDestination('Social'));
      await tester.pumpAndSettle();

      // Verify like and comment are preserved
      expect(find.text('1'), findsNWidgets(2)); // 1 like and 1 comment
      expect(find.byTooltip('Unlike'), findsOneWidget);
      expect(
        find.textContaining('IndexedStack persistence check'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Comments follow Instagram-style attribution and preserve original authors across account switch',
    (WidgetTester tester) async {
      DemoAuth.currentUsername = 'alice';
      await tester.pumpWidget(const MaterialApp(home: SocialMediaPage()));

      // Add a comment as alice
      final commentField = find
          .widgetWithText(TextField, 'Add a comment...')
          .first;
      await tester.ensureVisible(commentField);
      await tester.enterText(commentField, 'Hello from Alice!');
      await tester.ensureVisible(find.byTooltip('Post comment').first);
      await tester.tap(find.byTooltip('Post comment').first);
      await tester.pump();

      // Verify alice attribution
      expect(find.textContaining('alice'), findsOneWidget);
      expect(find.textContaining('Hello from Alice!'), findsOneWidget);

      // Switch account session to bob
      DemoAuth.currentUsername = 'bob';

      // Add a comment as bob
      await tester.ensureVisible(commentField);
      await tester.enterText(commentField, 'Hey Alice, Bob here!');
      await tester.ensureVisible(find.byTooltip('Post comment').first);
      await tester.tap(find.byTooltip('Post comment').first);
      await tester.pump();

      // Verify both comments exist with their respective original authors
      expect(find.textContaining('alice'), findsOneWidget);
      expect(find.textContaining('Hello from Alice!'), findsOneWidget);
      expect(find.textContaining('bob'), findsOneWidget);
      expect(find.textContaining('Hey Alice, Bob here!'), findsOneWidget);
      expect(find.text('2'), findsOneWidget); // 2 comments on first post
    },
  );

  testWidgets('Dashboard and Profile AppBars have no logout action icon', (
    WidgetTester tester,
  ) async {
    // 1. Dashboard AppBar has no logout button
    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byIcon(Icons.logout),
      ),
      findsNothing,
    );

    // 2. Profile AppBar has no logout button
    await tester.pumpWidget(const MaterialApp(home: ProfilePage()));
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byIcon(Icons.logout_rounded),
      ),
      findsNothing,
    );
  });

  testWidgets(
    'Logout button at bottom of Profile page clears session and navigates to LoginScreen',
    (WidgetTester tester) async {
      DemoAuth.currentUsername = 'activeStudent';
      await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

      // Scroll to bottom of ProfilePage to reveal the primary Logout button
      await tester.scrollUntilVisible(
        find.widgetWithText(ElevatedButton, 'Logout'),
        300,
      );
      await tester.pumpAndSettle();

      final logoutButton = find.widgetWithText(ElevatedButton, 'Logout');
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();

      // Verify redirected to LoginScreen and current user cleared
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(DemoAuth.currentUser, isNull);
      expect(DemoAuth.currentUsername, isNull);
    },
  );

  testWidgets(
    'Register screen has refined text and returns to Login via clickable Login action',
    (WidgetTester tester) async {
      await tester.pumpWidget(const StudentApp());

      // Open Register screen
      await tester.tap(find.widgetWithText(TextButton, 'Register'));
      await tester.pumpAndSettle();

      expect(find.text('Create an Account'), findsOneWidget);
      expect(find.text('Already have an account? '), findsOneWidget);

      // Tap clickable Login action
      final loginLink = find.widgetWithText(TextButton, 'Login');
      await tester.ensureVisible(loginLink);
      await tester.tap(loginLink);
      await tester.pumpAndSettle();

      // Verify back on Login screen
      expect(find.text('Welcome Back'), findsOneWidget);
    },
  );

  testWidgets(
    'Authenticated username propagates consistently to Dashboard, Social Media, and Profile',
    (WidgetTester tester) async {
      const authUser = 'scholar123';
      DemoAuth.currentUsername = authUser;

      await tester.pumpWidget(
        const MaterialApp(home: MainScreen(currentUsername: authUser)),
      );

      // 1. Dashboard displays personalized welcome message
      expect(find.text('Welcome, scholar123!'), findsOneWidget);
      expect(find.text('Active Session · @scholar123'), findsOneWidget);

      // 2. Social Media creates post under authenticated user
      await tester.tap(navDestination('Social'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.text('Posting as @scholar123'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // 3. Profile displays "Logged in as: scholar123"
      await tester.tap(navDestination('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Logged in as: scholar123'), findsOneWidget);
      expect(find.text('3rd Year (3447)'), findsOneWidget);
    },
  );

  testWidgets(
    'Dashboard overview navigation switches tabs to Calculator, Social, and Profile',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));

      // Overview tile for Calculator
      expect(
        find.text('Calculator'),
        findsNWidgets(2),
      ); // Navigation bar + Overview tile
      final calcTile = find.widgetWithText(ListTile, 'Calculator');
      await tester.ensureVisible(calcTile);
      await tester.tap(calcTile);
      await tester.pumpAndSettle();
      expect(find.text('BASIC CALCULATOR'), findsOneWidget);

      // Switch back to Dashboard
      await tester.tap(navDestination('Dashboard'));
      await tester.pumpAndSettle();

      // Overview tile for Social
      final socialTile = find.widgetWithText(ListTile, 'Social');
      await tester.ensureVisible(socialTile);
      await tester.tap(socialTile);
      await tester.pumpAndSettle();
      expect(find.text('Social Media Feed'), findsOneWidget);

      // Switch back to Dashboard
      await tester.tap(navDestination('Dashboard'));
      await tester.pumpAndSettle();

      // Overview tile for Profile
      final profileTile = find.widgetWithText(ListTile, 'Profile');
      await tester.ensureVisible(profileTile);
      await tester.tap(profileTile);
      await tester.pumpAndSettle();
      expect(find.text('Earth Justin Lim'), findsOneWidget);
    },
  );

  testWidgets(
    'DemoAuth adapts currentUser and currentUsername bidirectionally',
    (WidgetTester tester) async {
      DemoAuth.currentUser = 'alpha';
      expect(DemoAuth.currentUsername, 'alpha');

      DemoAuth.currentUsername = 'beta';
      expect(DemoAuth.currentUser, 'beta');

      DemoAuth.logout();
      expect(DemoAuth.currentUser, isNull);
      expect(DemoAuth.currentUsername, isNull);
    },
  );
}
