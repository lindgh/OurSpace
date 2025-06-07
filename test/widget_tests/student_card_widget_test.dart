import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:OurSpace/models/student_card_model.dart';
import 'package:OurSpace/models/student_card_widget.dart';

void main() {
  testWidgets('Shows match dialog when addInquiredUser returns true', (WidgetTester tester) async {
    // Setup fake student card
    final student = StudentCard(
      uid: 'swipedUser123',
      UserName: 'Test User',
      UserMajor: 'Computer Science',
      UserCollege: 'Engineering',
      UserGradYear: '2026',
      UserBio: 'Hi! This is my bio.',
      profileImagePath: '',
    );

    // Inject fake addInquiredUser function
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StudentCardWidget(
            student: student,
            addInquiredUserFn: (uid) async => true, // mock a match
          ),
        ),
      ),
    );

    // Simulate a right swipe
    final gesture = await tester.startGesture(const Offset(300, 300));
    await gesture.moveBy(const Offset(150, 0)); // swipe right
    await gesture.up();

    await tester.pumpAndSettle(); // wait for dialog

    // Now we expect the dialog to be visible
    expect(find.text("It's a Match! 😊"), findsOneWidget);
    expect(find.textContaining('have matched'), findsOneWidget);
  });
}
