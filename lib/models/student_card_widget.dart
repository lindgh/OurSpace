import 'package:flutter/material.dart';
import 'student_card_model.dart'; // The StudentCard data class

class StudentCardWidget extends StatefulWidget {
  final StudentCard student;

  const StudentCardWidget({super.key, required this.student});

  @override
  State<StudentCardWidget> createState() => _StudentCardWidgetState();
}

class _StudentCardWidgetState extends State<StudentCardWidget> {
  String selectedSection = 'Study Focus'; // ✅ This should already be true

  @override
  Widget build(BuildContext context) {
    final student = widget.student;
    final screenHeight = MediaQuery.of(context).size.height;

    final Map<String, Widget> infoContent = {
      'School': Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            student.school,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: Image.asset(
                student.schoolImagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),






      'Study Focus': Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(student.majorTitle, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: student.courses.map((course) => _CoursePill(label: course)).toList(),
            ),
            const SizedBox(height: 24),
            Text(student.studyFocusText, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),





      'Bio': Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(student.profileImagePath),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(student.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(student.school, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _SocialIconButton(icon: Icons.link, label: 'LinkedIn'),
                SizedBox(width: 24),
                _SocialIconButton(icon: Icons.email, label: 'Email'),
                SizedBox(width: 24),
                _SocialIconButton(icon: Icons.share, label: 'Other'),
              ],
            ),
            const SizedBox(height: 24),
            Text(student.bio, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    };

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.33,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(student.headerImagePath, fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      color: Colors.black.withOpacity(0.3),
                      child: Text(
                        student.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Toggle Buttons
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _InfoButton(
                  icon: Icons.school,
                  label: 'School',
                  isSelected: selectedSection == 'School',
                  onTap: () => setState(() => selectedSection = 'School'),
                ),
                _InfoButton(
                  icon: Icons.menu_book,
                  label: 'Study Focus',
                  isSelected: selectedSection == 'Study Focus',
                  onTap: () => setState(() => selectedSection = 'Study Focus'),
                ),
                _InfoButton(
                  icon: Icons.person,
                  label: 'Bio',
                  isSelected: selectedSection == 'Bio',
                  onTap: () => setState(() => selectedSection = 'Bio'),
                ),
              ],
            ),
          ),

          // Dynamic Section Content
          Expanded(
            child: selectedSection == 'School'
                ? infoContent[selectedSection]!
                : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: infoContent[selectedSection]!,
            ),
          ),
        ],
      ),
    );
  }
}

// Subcomponents

class _CoursePill extends StatelessWidget {
  final String label;

  const _CoursePill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }
}

class _InfoButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _InfoButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.indigoAccent : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: Colors.black)),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialIconButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.indigoAccent.withOpacity(0.1),
          ),
          child: Icon(icon, size: 24, color: Colors.indigo),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
