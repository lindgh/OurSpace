import 'package:flutter_test/flutter_test.dart';
import 'package:OurSpace/models/student_card_model.dart';
import 'package:OurSpace/services/matching/matching_algorithm.dart'; // Update path if needed
import 'package:OurSpace/services/auth/user.dart'; // Update path if needed

void main() {
  group('DefaultMatchingAlgorithm', () {
    late UserData mockCurrentUser;
    late DefaultMatchingAlgorithm matchingAlgorithm;

    setUp(() {
      mockCurrentUser = UserData(
        UserUID: '123',
        UserEmail: 'test@example.com',
        UserName: 'Current User',
        UserMajor: 'CEN',
        UserCollege: 'UCR',
        UserGradYear: '2025',
        UserBiography: 'Bio',
        UserProfilePicture: '',
        inquiredUsers: [],
        matchedUsers: [],
      );

      matchingAlgorithm = DefaultMatchingAlgorithm(currUser: mockCurrentUser);
    });

    test('returns 0 when there are no matching fields', () async {
      final otherUser = StudentCard(
        uid: '456',
        UserName: 'Other User',
        UserMajor: 'CS',
        UserCollege: 'CSUSM',
        UserGradYear: '2024',
        UserBio: 'Other Bio',
        profileImagePath: '',
      );

      final score = await matchingAlgorithm.calculateScore(otherUser);
      expect(score, 0);
    });

    test('returns 3 when only major matches', () async {
      final otherUser = StudentCard(
        uid: '456',
        UserName: 'Other User',
        UserMajor: 'CEN',
        UserCollege: 'CSUSM',
        UserGradYear: '2024',
        UserBio: 'Other Bio',
        profileImagePath: '',
      );

      final score = await matchingAlgorithm.calculateScore(otherUser);
      expect(score, 3);
    });

    test('returns 6 when all attributes match', () async {
      final otherUser = StudentCard(
        uid: '456',
        UserName: 'Other User',
        UserMajor: 'CEN',
        UserCollege: 'UCR',
        UserGradYear: '2025',
        UserBio: 'Other Bio',
        profileImagePath: '',
      );

      final score = await matchingAlgorithm.calculateScore(otherUser);
      expect(score, 6);
    });
  });
}
