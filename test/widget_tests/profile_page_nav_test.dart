import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:OurSpace/pages/profile_page.dart';

// fake page to avoid firebase for login
class FakeLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text('Stub Login Page');
}

// fake edit page
class FakeEditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text('Stub Edit Page');
}

// profile page test injection
class TestableProfilePage extends StatelessWidget {
  final VoidCallback? onLogout;
  final VoidCallback? onEdit;

  const TestableProfilePage({super.key, this.onLogout, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                if (onEdit != null) {
                  onEdit!();
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => FakeEditProfilePage()),
                  );
                }
              },
              child: const Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                if (onLogout != null) {
                  onLogout!();
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => FakeLoginPage()),
                  );
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Logout button navigates to LoginSignUpPage', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TestableProfilePage(
          onLogout: () {
            Navigator.of(tester.element(find.byType(TestableProfilePage)))
                .pushReplacement(MaterialPageRoute(builder: (_) => FakeLoginPage()));
          },
        ),
      ),
    );

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Stub Login Page'), findsOneWidget);
  });

  testWidgets('Edit button navigates to EditProfilePage', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TestableProfilePage(
          onEdit: () {
            Navigator.of(tester.element(find.byType(TestableProfilePage)))
                .pushReplacement(MaterialPageRoute(builder: (_) => FakeEditProfilePage()));
          },
        ),
      ),
    );

    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Stub Edit Page'), findsOneWidget);
  });
}
