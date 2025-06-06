import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:OurSpace/models/student_card_model.dart';
import 'package:OurSpace/pages/discover_page.dart';

void main() {
  testWidgets('DiscoverPage displays cards when users are loaded',
    (WidgetTester tester) async {

      final mockUsers = [
        StudentCard(
          UserName: 'Test User',
          UserCollege: 'Test College',
          UserGradYear: '2025',
          UserMajor: 'Test Major',
          profileImagePath: '',
          UserBio: 'Test Bio',
          uid: 'Test UID'
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: DiscoverPage(
            getAllUserDataFunc: () async => mockUsers,
            sortFunc: (users) async => users,
          ),
        ),
      );

    await tester.pumpAndSettle();

    expect(find.text('Test User'), findsOneWidget);
  });
}