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

  testWidgets('Swipe left prints NOT INTERESTED', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StudentCardWidget(
            student: student,
            isTest: true,
          ),
        ),
      ),
    );

    await expectLater(() async {
      final gesture = await tester.startGesture(const Offset(300, 300));
      await gesture.moveBy(const Offset(-200, 0));
      await gesture.up();
      await tester.pumpAndSettle();
    }, prints(contains('NOT INTERESTED')));
  });

  testWidgets('Swipe right prints INTERESTED', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StudentCardWidget(
            student: student,
            isTest: true,
          ),
        ),
      ),
    );

    await expectLater(() async {
      final gesture = await tester.startGesture(const Offset(100, 300));
      await gesture.moveBy(const Offset(200, 0));
      await gesture.up();
      await tester.pumpAndSettle();
    }, prints(contains('INTERESTED')));
  });
}
