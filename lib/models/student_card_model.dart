class StudentCard {
  /*
    name
    -Study Focus
    -Bio
   */
  final String name;

  /*
    school
    -School
    -Bio
   */
  final String school;

  /*
    majorTitle
    -Study Focus
   */
  final String majorTitle;

  /*
    headerImagePath
    -TOP of CARD Image (must update pubspec.yaml to add more images)
        - images can also be used with an internet link
   */
  final String headerImagePath;

  /*
    profileImagePath
    - BIO pfp (must update pubspec.yaml to add more images)
        - images can also be used with an internet link
   */
  final String profileImagePath;

  /*
    schoolImagePath
    -School Profile Image (must update pubspec.yaml to add more images)
        - images can also be used with an internet link
   */
  final String schoolImagePath;

  /*
    courses
    - 'pills' on the study focus
  */
  final List<String> courses;

  /*
    studyFocusText
    - appears on study focus
   */
  final String studyFocusText;

  /*
    bio
    - bio text
   */
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
