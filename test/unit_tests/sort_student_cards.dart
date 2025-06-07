import 'package:OurSpace/services/auth/user.dart';
import 'package:OurSpace/services/matching/sort_student_cards.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:OurSpace/models/student_card_model.dart';
import 'package:mockito/mockito.dart';

import '../mocks.mocks.dart';


void main() {
  late MockDefaultMatchingAlgorithm mockMatch;

  setUp(() {
    mockMatch = MockDefaultMatchingAlgorithm();
  });

  test('Sorter ranks cards by score', () async {
    mockMatch = MockDefaultMatchingAlgorithm();

    final input = [
      StudentCard(
        UserName: 'A',
        UserMajor: 'CS',
        UserCollege: 'MyCollege',
        UserGradYear: '2025',
        UserBio: '',
        profileImagePath: '',
        uid: '1',
      ),
      StudentCard(
        UserName: 'B',
        UserMajor: 'Math',
        UserCollege: 'Other',
        UserGradYear: '2024',
        UserBio: '',
        profileImagePath: '',
        uid: '2',
      ),
    ];

    when(mockMatch.calculateScore(input[0])).thenAnswer((_) async => 1);
    when(mockMatch.calculateScore(input[1])).thenAnswer((_) async => 3);

    final list = SortStudentCards(match: mockMatch);
    final sorted = await list.sort(input);

    expect(sorted.first.UserName, equals('A'));
    expect(sorted.last.UserName, equals('B'));
  });
}
