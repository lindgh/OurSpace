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

class MatchingAlgorithm {
  static Future<List<StudentCard>> sortedStudents({
    required List<StudentCard>? otherUsers,
  }) async
  {
    final currentUser = await UserData.fetchCurrentUser();
    List<StudentScore> sortedList = await Future.wait(otherUsers!.map((user) async {
      int score = 0;
      if (user.UserGraduationYear == currentUser!.UserGraduationYear) score += 1;
      if (user.UserCollege == currentUser.UserCollege) score += 2;
      if (user.UserMajor == currentUser.UserMajor) score += 3;
      return StudentScore(score: score, student: user);
    }),
    );

    sortedList.sort((a,b) => a.score.compareTo(b.score));

    // print("sorted scores:");
    // for (var s in sortedList) {
    //   print("${s.student.UserName} - Score: ${s.score}");
    // }

    return sortedList.map((s) => s.student).toList();
  }
}
