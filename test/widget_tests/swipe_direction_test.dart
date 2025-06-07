import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:OurSpace/models/student_card_model.dart';
import 'package:OurSpace/models/student_card_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final student = StudentCard(
    UserName: 'Test User',
    UserMajor: 'Engineering',
    UserGradYear: '2026',
    UserCollege: 'UCR',
    profileImagePath: '',
    UserBio: 'Test bio',
    uid: 'test-uid',
  );

  testWidgets('Swipe right prints INTERESTED', (WidgetTester tester) async {
    final student = StudentCard(
      uid: 'test123',
      UserName: 'Swipe Test',
      UserMajor: 'Physics',
      UserCollege: 'Science',
      UserGradYear: '2025',
      UserBio: 'Just testing swipe.',
      profileImagePath: '',
    );


    Future<bool> fakeAddInquiredUser(String _) async => false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StudentCardWidget(
            student: student,
            addInquiredUserFn: fakeAddInquiredUser,
          ),
        ),
      ),
    );

    final gesture = await tester.startGesture(const Offset(300, 300));
    await gesture.moveBy(const Offset(150, 0)); // swipe right
    await gesture.up();

    await tester.pumpAndSettle();

  });

}
