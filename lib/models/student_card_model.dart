class StudentCard {
  final String UserName;
  final String UserCollege;
  final String UserMajor;
  final String UserGradYear;
  final String headerImagePath;
  final String profileImagePath;
  final String schoolImagePath;
  final List<String> courses;
  final String studyFocusText;
  final String UserBio;
  final String uid;

  StudentCard({
    required this.UserName,
    required this.UserCollege,
    required this.headerImagePath,
    required this.profileImagePath,
    required this.schoolImagePath,
    required this.UserMajor,
    required this.UserGradYear,
    required this.courses,
    required this.studyFocusText,
    required this.UserBio,
    required this.uid
  });
}
