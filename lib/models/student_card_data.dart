import 'student_card_model.dart';

final List<StudentCard> studentCards = [
  StudentCard(
    name: "Oscar Isaac",
    school: "University of California, Riverside",
    majorTitle: "Computer Science",
    headerImagePath: "assets/images/placeholder_OI.jpg",
    profileImagePath: "assets/images/placeholder_OI_pfp.jpg",
    schoolImagePath: "assets/images/placeholder_school_ucr.jpg",
    courses: ["CS147", "CS173", "EE120B", "MATH009B", "EE108"],
    studyFocusText: "Looking for someone to help me study the CS153 exam. I really don't understand this stuff. \n\nMaybe if you help me learn a lot, I'll take you out on a date..",
    bio: "I love computer science as much as I love acting. Add me on Discord!",
  ),
  StudentCard(
    name: "Pedro Pascal",
    school: "University of California, Los Angeles",
    majorTitle: "Mechanical Engineering",
    headerImagePath: "assets/images/placeholder_PP.jpg",
    profileImagePath: "assets/images/placeholder_PP_pfp.jpg",
    schoolImagePath: "assets/images/placeholder_school_ucla.jpg",
    courses: ["PHYS040C", "MATH010B", "EE128"],
    studyFocusText: "Looking for a project partner to help save the world against Galactus. We are not safe.",
    bio: "I really really hate Tony Stark. Also, I hate Namor.",
  ),

];
