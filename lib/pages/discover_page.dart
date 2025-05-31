import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/student_card_widget.dart';
import '../models/student_card_data.dart';
import '../models/student_card_model.dart';
import '../services/matching/matchingAlgorithm.dart';

class DiscoverPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => DiscoverPage(),
  );
  DiscoverPage({super.key});

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
    List<StudentCard> unsortedList = await getAllUserData();
    _currentCards = await MatchingAlgorithm.sortedStudents(otherUsers: unsortedList);
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
          cards: _currentCards
          !.map((student) => StudentCardWidget(student: student))
              .toList(),
          onEnd: _onEnd,
        ),
      ),
    );
  }
}