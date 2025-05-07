import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    //SWIPING DETECTION
    return Padding(
      padding: const EdgeInsets.all(8), // <-- adds margin around the card
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
              SizedBox(
                height: screenHeight * 0.33,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      //STUDENT IMAGE (Aiming for this to be a )
                      Image.network(
                        'https://relevantmagazine.com/wp-content/uploads/2025/02/oscarisaacc.jpg',
                        fit: BoxFit.cover,
                      ),


                      // NAME AT THE BOTTOM OF THE IMAGE
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          color: Colors.black.withOpacity(0.5),

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

              // Spacer or future content
              const Expanded(
                child: Center(
                  child: Text(
                    "More content coming...",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
