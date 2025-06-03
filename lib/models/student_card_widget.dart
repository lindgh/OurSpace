import 'package:flutter/material.dart';
import 'student_card_model.dart';

class StudentCardWidget extends StatefulWidget {
  final StudentCard student;

  const StudentCardWidget({super.key, required this.student});

  @override
  State<StudentCardWidget> createState() => _StudentCardWidgetState();
}

class _StudentCardWidgetState extends State<StudentCardWidget> {
  double _startX = 0.0;
  String selectedSection = 'Bio';

  @override
  Widget build(BuildContext context) {
    final student = widget.student;
    final screenHeight = MediaQuery.of(context).size.height;

    final Map<String, Widget> infoContent = {
      'Bio': Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(student.UserName, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(student.UserMajor, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(student.UserCollege, style: const TextStyle(fontSize: 20, color: Colors.grey)),
                            const SizedBox(height: 2),
                            Text(student.UserGradYear, style: const TextStyle(fontSize: 20, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text(student.UserBio, style: const TextStyle(fontSize: 23, color: Colors.black)),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    };

    return Stack(
      children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.50,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Positioned.fill(child: Image.network(
                        student.profileImagePath,
                        fit:BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
              ),

              // Dynamic Section Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: infoContent[selectedSection]!,
                ),
              ),
            ],
          ),
        ),

        // Swiping behavior
        Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              _startX = event.position.dx;
            },
            onPointerUp: (event) {
              final endX = event.position.dx;
              final swipeDistance = endX - _startX;

              if (swipeDistance < -90) {
                debugPrint('Final Swipe: Left');
              } else if (swipeDistance > 90) {
                debugPrint('Final Swipe: Right');
              }
            },
            child: Container(),
          ),
        ),
      ],
    );
  }
}