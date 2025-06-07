import '../../models/student_card_model.dart';
import '../auth/user.dart';

class StudentScore {
  final int score;
  final StudentCard student;

  StudentScore({
    required this.score,
    required this.student
  });
}

abstract class MatchingAlgorithm {
  Future<int> calculateScore(StudentCard otherUser);
}

class DefaultMatchingAlgorithm implements MatchingAlgorithm {
  final UserData currUser;

  DefaultMatchingAlgorithm({
    required this.currUser
  });

  @override
  Future<int> calculateScore(StudentCard otherUser) async {
    int score = 0;

    if (otherUser.UserGradYear == currUser.UserGradYear) score += 1;
    if (otherUser.UserCollege == currUser.UserCollege) score += 2;
    if (otherUser.UserMajor == currUser.UserMajor) score += 3;

    return score;
  }
}
