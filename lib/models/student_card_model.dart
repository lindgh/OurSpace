class StudentCard {
  final String UserName;
  final String UserCollege;
  final String UserMajor;
  final String UserGraduationYear;
  final String headerImagePath;
  final String profileImagePath;
  final String schoolImagePath;
  final List<String> courses;
  final String studyFocusText;
  final String bio;

  StudentCard({
    required this.UserName,
    required this.UserCollege,
    required this.headerImagePath,
    required this.profileImagePath,
    required this.schoolImagePath,
    required this.UserMajor,
    required this.UserGraduationYear,
    required this.courses,
    required this.studyFocusText,
    required this.bio,
  });
}
