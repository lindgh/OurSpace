import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:OurSpace/pages/navigation_bar.dart';

// STUB PAGES
class FakeDiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text('Stub Discover Page');
}

class FakeMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text('Stub Message Page');
}

class FakeProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text('Stub Profile Page');
}
//////////


void main() {
  testWidgets('NavBar switches pages correctly', (tester) async {
    final fakePages = [
      FakeDiscoverPage(),
      FakeMessagePage(),
      FakeProfilePage(),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: NavBar(overridePages: fakePages),
      ),
    );

    expect(find.text('Stub Discover Page'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.messenger));
    await tester.pumpAndSettle();
    expect(find.text('Stub Message Page'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    expect(find.text('Stub Profile Page'), findsOneWidget);
  });

  testWidgets('Navigate to ProfilePage from index value', (tester) async {
    final fakePages = [
      FakeDiscoverPage(),
      FakeMessagePage(),
      FakeProfilePage(),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: NavBar(overridePages: fakePages, index: 2), // profile page index
      ),
    );

    expect(find.byType(FakeProfilePage), findsOneWidget);
    expect(find.byType(FakeDiscoverPage), findsNothing);
    expect(find.byType(FakeMessagePage), findsNothing);
  });

  testWidgets('Navigate to MessagePage from index value', (tester) async {
    final fakePages = [
      FakeDiscoverPage(),
      FakeMessagePage(),
      FakeProfilePage(),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: NavBar(overridePages: fakePages, index: 1), // message page index
      ),
    );

    expect(find.byType(FakeMessagePage), findsOneWidget);
    expect(find.byType(FakeProfilePage), findsNothing);
    expect(find.byType(FakeDiscoverPage), findsNothing);
  });

  testWidgets('Navigate to DiscoverPage from index value', (tester) async {
    final fakePages = [
      FakeDiscoverPage(),
      FakeMessagePage(),
      FakeProfilePage(),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: NavBar(overridePages: fakePages, index: 0), // discover page index
      ),
    );

    expect(find.byType(FakeDiscoverPage), findsOneWidget);
    expect(find.byType(FakeProfilePage), findsNothing);
    expect(find.byType(FakeMessagePage), findsNothing);
  });
}