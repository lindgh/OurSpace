import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedSection = 'School';

  final Map<String, Widget> infoContent = {
    'School': Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/school_logo.png', height: 60),
        const SizedBox(height: 12),
        const Text(
          'University of California, Riverside',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    'Study Focus': Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'CS 141 - AI and ML',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          child: const Text("View Notes"),
        ),
      ],
    ),
    'Bio': const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Text(
          'Loves group projects, coffee, and study jams. Also a part-time tutor for Data Structures. Enjoys climbing and weekend hackathons.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
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
                  child: Center(
                    child: infoContent[selectedSection]!,
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
