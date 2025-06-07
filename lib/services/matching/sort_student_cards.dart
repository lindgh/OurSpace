import '../../models/student_card_model.dart';
import 'matching_algorithm.dart';

class SortStudentCards {
  final MatchingAlgorithm match;

  SortStudentCards({
    required this.match
  });

  Future<List<StudentCard>> sort(List<StudentCard> cards) async {
    final sortedCards = await Future.wait(cards.map((card) async {
      final score = await match.calculateScore(card);
      return StudentScore(score: score, student: card);
  }));

  sortedCards.sort((a,b) => a.score.compareTo(b.score));

  //print statement for debugging purposes
  // print("sorted scores:");
  // for (var s in sortedCards) {
  //   print("${s.student.UserName} - Score: ${s.score}");
  // }

    return sortedCards.map((s) => s.student).toList();
  }
}