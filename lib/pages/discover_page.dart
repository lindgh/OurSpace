import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedSection = 'Study Focus';
// SCHOOL SECTION
  final Map<String, Widget> infoContent = {
    'School': Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24), // ⬅️ More space below the buttons
        const Text(
          'University of California, Riverside',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16), // ⬅️ Space before image

        // FULL-WIDTH IMAGE (NO RADIUS, NO MARGIN)
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            child: Image.asset(
              'assets/images/placeholder_school_ucr.jpg',
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
        crossAxisAlignment: CrossAxisAlignment.start, // Ensures text is left-aligned
        children: [
          const Text(
            'Computer Science',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 0),
          const Text(
            'Undergrad, fourth year',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // Wrap inside a Center to override left alignment
          Center(
            child: Wrap(
              alignment: WrapAlignment.center, // Still center-align pills
              spacing: 12,
              runSpacing: 8,
              children: [
                _CoursePill(label: 'CS147'),
                _CoursePill(label: 'CS173'),
                _CoursePill(label: 'EE120B'),
                _CoursePill(label: 'MATH009B'),
                _CoursePill(label: 'EE108'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Looking for a partner to study for the upcoming CS153 exam!\n\nNow we gotta test to make sure that the text fades to white when there is too much text to fit within the box. This will come up later probably. I fear that the team will not like what I have made, but the only thing I can do is hope for the best.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),






    'Bio': Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PROFILE + NAME/SCHOOL ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/placeholder_OI_pfp.jpg'),
              ),
              const SizedBox(width: 16),
              Expanded( // ← this allows wrapping instead of overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Oscar Isaac',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'University of California, Riverside',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // SOCIAL ICON BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _SocialIconButton(icon: Icons.link, label: 'LinkedIn'),
              SizedBox(width: 24), // ⬅️ increased spacing
              _SocialIconButton(icon: Icons.email, label: 'Email'),
              SizedBox(width: 24), // ⬅️ increased spacing
              _SocialIconButton(icon: Icons.share, label: 'Other'),
            ],
          ),

          const SizedBox(height: 24),

          // BIO TEXT (LEFT-ALIGNED)
          const Text(
            'I love computer science as much as I love acting. '
                'Feel free to add me on my discord  - linked above ;) <3',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),



  };


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    //SWIPING DETECTION
    return SafeArea(
      top: true,
      bottom: false, // optional: keeps the card overlapping the navbar if desired
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx > 10) {
              print("Swiped Right");
            } else if (details.delta.dx < -10) {
              print("Swiped Left");
            }
          },

          //DISCOVERY PAGE CONTENT
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [

                //STUDENT IMAGE + NAME
                Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SizedBox(
                    height: screenHeight * 0.33,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          //STUDENT IMAGE (aiming for this to be customizable by user)
                          Image.asset(
                            'assets/images/placeholder_OI.jpg',
                            fit: BoxFit.cover,
                          ),

                          // NAME AT THE BOTTOM OF THE IMAGE
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              color: Colors.black.withOpacity(0.3),
                              child: const Text(
                                'Oscar Isaac',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

// BUTTONS TO TOGGLE BETWEEN INFO SECTIONS
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 12.0), // ⬅️ lowered the button row
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoButton(
                        icon: Icons.school,
                        label: 'School',
                        isSelected: selectedSection == 'School',
                        onTap: () {
                          setState(() {
                            selectedSection = 'School';
                          });
                        },
                      ),
                      _InfoButton(
                        icon: Icons.menu_book,
                        label: 'Study Focus',
                        isSelected: selectedSection == 'Study Focus',
                        onTap: () {
                          setState(() {
                            selectedSection = 'Study Focus';
                          });
                        },
                      ),
                      _InfoButton(
                        icon: Icons.person,
                        label: 'Bio',
                        isSelected: selectedSection == 'Bio',
                        onTap: () {
                          setState(() {
                            selectedSection = 'Bio';
                          });
                        },
                      ),
                    ],
                  ),
                ),

// DYNAMIC CONTENT BASED ON SELECTED BUTTON
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final current = infoContent[selectedSection]!;

                      // Don't wrap School section, it already has full-height content
                      if (selectedSection == 'School') {
                        return current;
                      }

                      // Scrollable content for Study Focus and Bio
                      return ClipRRect(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          child: current,
                        ),
                      );
                    },
                  ),
                ),





              ],
            ),
          ),
        ),
      ),
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
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

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
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialIconButton({
    required this.icon,
    required this.label,
  });

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
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}


