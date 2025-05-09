import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../models/student_card_widget.dart';
import '../models/student_card_data.dart';
import '../models/student_card_model.dart'; // <-- your StudentCard class


class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final Random _random = Random();
  late List<StudentCard> _currentCards;

  @override
  void initState() {
    super.initState();
    _reshuffleCards();
  }

  void _reshuffleCards() {
    _currentCards = List<StudentCard>.from(studentCards)..shuffle(_random);
  }

  void _onEnd() {
    setState(() {
      _reshuffleCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CardSwiper(

          cards: _currentCards.map((student) => StudentCardWidget(student: student)).toList(),
          onEnd: _onEnd,
        ),
      ),
    );
  }
}
