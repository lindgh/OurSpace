class StudentCard {
  final String name;
  final String school;
  final String headerImagePath;
  final String profileImagePath;
  final List<String> courses;
  final String studyFocusText;
  final String bio;

  StudentCard({
    required this.name,
    required this.school,
    required this.headerImagePath,
    required this.profileImagePath,
    required this.courses,
    required this.studyFocusText,
    required this.bio,
  });
}
