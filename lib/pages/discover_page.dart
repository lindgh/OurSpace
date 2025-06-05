import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/student_card_widget.dart';
import '../models/student_card_data.dart';
import '../models/student_card_model.dart';
import '../services/matching/matchingAlgorithm.dart';

class DiscoverPage extends StatefulWidget {
  final Future<List<StudentCard>> Function()? getAllUserDataFunc;
  final Future<List<StudentCard>> Function(List<StudentCard>)? sortFunc;

  DiscoverPage({
    super.key,
    this.getAllUserDataFunc,
    this.sortFunc,
  });

  static route() => MaterialPageRoute(
    builder: (context) => DiscoverPage(),
  );

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<StudentCard>? _currentCards = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final othersList = await (widget.getAllUserDataFunc?.call() ?? getAllUserData());
    _currentCards = await (widget.sortFunc?.call(othersList) ??
        MatchingAlgorithm.sortedStudents(otherUsers: othersList));
    setState(() {});
  }

  void _onEnd() {
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: _currentCards == null
            ? Center(child: CircularProgressIndicator())
            : _currentCards!.isEmpty
            ? Center(child: CircularProgressIndicator()) //child: Text('No users found.'))
            : CardSwiper(
              numberOfCardsDisplayed: (_currentCards?.length ?? 0).clamp(1, _currentCards?.length ?? 1),
              threshold: 70,
          cards: _currentCards
            !.map((student) => StudentCardWidget(student: student)).toList(),
          onEnd: _onEnd,
        ),
      ),
    );
  }
}