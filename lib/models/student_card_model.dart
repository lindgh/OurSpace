class StudentCard {
  final String name;
  final String school;
  final String majorTitle;
  final String headerImagePath;
  final String profileImagePath;
  final String schoolImagePath;
  final List<String> courses;
  final String studyFocusText;
  final String bio;

  StudentCard({
    required this.name,
    required this.school,
    required this.headerImagePath,
    required this.profileImagePath,
    required this.schoolImagePath,
    required this.majorTitle,
    required this.courses,
    required this.studyFocusText,
    required this.bio,
  });
}
