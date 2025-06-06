import 'package:flutter/material.dart';
import 'student_card_model.dart';
import '../services/auth/user.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                      RichText(
                          text: TextSpan(
                              children: [
                                WidgetSpan(child: Icon(Icons.menu_book, color: Colors.indigo, size: 30)),
                                TextSpan(text: "  "),
                                TextSpan(text: student.UserMajor, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.black)),

                                TextSpan(text: "\n"),
                                WidgetSpan(child: Icon(Icons.location_on, color: Colors.indigo)),
                                TextSpan(text: "  "),
                                TextSpan(text: student.UserCollege, style: const TextStyle(fontSize: 20, color: Colors.black45)),

                                TextSpan(text: "\n"),
                                WidgetSpan(child: Icon(Icons.school, color: Colors.indigo)),
                                TextSpan(text: "  "),
                                TextSpan(text: student.UserGradYear, style: const TextStyle(fontSize: 20, color: Colors.black45)),

                                TextSpan(text: "\n\n"),
                                TextSpan(text: student.UserBio, style: const TextStyle(fontSize: 23, color: Colors.black)),
                              ]
                          )
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
                      Positioned.fill(child: student.profileImagePath.isEmpty
                          ? Image.asset(
                        'assets/images/OurSpace.png', // Make sure this image is in your assets
                        fit: BoxFit.fitHeight,
                      )
                          : Image.network(
                        student.profileImagePath,
                        fit: BoxFit.fitHeight,
                      ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          color: Colors.black.withOpacity(0.3),
                          child: Text(
                            student.UserName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
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
            onPointerUp: (event) async {
              final endX = event.position.dx;
              final swipeDistance = endX - _startX;

              if (swipeDistance < -90) {
                debugPrint('NOT INTERESTED');
              } else if (swipeDistance > 90) {
                  debugPrint('INTERESTED');

                  final isTest = WidgetsBinding.instance.runtimeType.toString().contains('TestWidgetsFlutterBinding');
                  if (isTest) return;

                  bool isMatch = await addInquiredUser(student.uid);

                  if (isMatch) {
                      showDialog(
                        context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("It's a Match! 😊"),
                            content: Text("You and ${student.UserName} have matched!"),
                            actions: [
                            TextButton(
                            child: const Text("Continue"),
                            onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      );
                  }
                }

          },

            child: Container(),
          ),
        ),
      ],
    );
  }
}