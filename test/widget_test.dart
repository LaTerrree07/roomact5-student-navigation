import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lim_navigation_app/demo_auth.dart';
import 'package:lim_navigation_app/login_screen.dart';
import 'package:lim_navigation_app/main.dart';
import 'package:lim_navigation_app/main_screen.dart';
import 'package:lim_navigation_app/profile_page.dart';
import 'package:lim_navigation_app/social_media/social_media.dart';
import 'package:lim_navigation_app/social_media_page.dart';

void main() {
  setUp(() {
    DemoAuth.registeredUsername = null;
    DemoAuth.registeredPassword = null;
    DemoAuth.currentUser = null;
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
      expect(DemoAuth.currentUser, 'student1');
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
    expect(DemoAuth.currentUser, 'admin');
  });

  testWidgets(
    'Navigation bar switches across all 4 destinations including Social Media feed',
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
      expect(find.text('Social Media Feed'), findsOneWidget);
      expect(find.text('JohnDoe'), findsOneWidget);
      final feedList = find.descendant(
        of: find.byType(SocialMediaScreen),
        matching: find.byType(ListView),
      );
      await tester.drag(feedList, const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(find.text('JaneSmith'), findsOneWidget);
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
      expect(find.text('Year / Code'), findsOneWidget);
      expect(find.text('3rd Year (3447)'), findsOneWidget);
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

  testWidgets(
    'Social Media Feed liking, unliking, and commenting work properly',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SocialMediaScreen()));

      expect(find.text('JohnDoe'), findsOneWidget);
      expect(find.text('Enjoying the sunny weather!'), findsOneWidget);

      // Tap Like on first post
      await tester.tap(find.byTooltip('Like').first);
      await tester.pump();

      expect(
        find.text('1'),
        findsOneWidget,
      ); // Like count incremented from 0 to 1
      expect(find.byTooltip('Unlike'), findsOneWidget);

      // Tap Unlike
      await tester.tap(find.byTooltip('Unlike'));
      await tester.pump();

      expect(find.text('1'), findsNothing); // Like count decremented back to 0

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
      expect(
        find.text('1'),
        findsOneWidget,
      ); // Comment count updated from 0 to 1

      // Verify JaneSmith exists in list
      final feedList = find.descendant(
        of: find.byType(SocialMediaScreen),
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
      DemoAuth.currentUser = 'testerUser';
      await tester.pumpWidget(const MaterialApp(home: SocialMediaScreen()));

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
      DemoAuth.currentUser = 'persistentStudent';
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));

      // Switch to Social Media tab
      await tester.tap(navDestination('Social Media'));
      await tester.pumpAndSettle();

      // Like JohnDoe's post
      await tester.tap(find.byTooltip('Like').first);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      // Scroll slightly up so comment bar is safely away from bottom navigation bar
      final feedList = find.descendant(
        of: find.byType(SocialMediaScreen),
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

      // Switch away to Home tab
      await tester.tap(navDestination('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Welcome, Student!'), findsOneWidget);

      // Switch back to Social Media tab
      await tester.tap(navDestination('Social Media'));
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
      DemoAuth.currentUser = 'alice';
      await tester.pumpWidget(const MaterialApp(home: SocialMediaScreen()));

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
      DemoAuth.currentUser = 'bob';

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

  testWidgets('Logout clears session and navigates to LoginScreen', (
    WidgetTester tester,
  ) async {
    DemoAuth.currentUser = 'activeStudent';
    await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

    expect(find.byType(ProfilePage), findsOneWidget);

    // Tap Logout button in Profile AppBar
    await tester.tap(find.byTooltip('Log out'));
    await tester.pumpAndSettle();

    // Verify redirected to LoginScreen and currentUser cleared
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(DemoAuth.currentUser, isNull);
  });
}
