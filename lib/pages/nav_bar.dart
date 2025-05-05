import 'package:flutter/material.dart';
import 'discover_page.dart';
import 'message_page.dart';
import 'profile_page.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _MainPageState();
}

class _MainPageState extends State<NavBar> {

  final List<Widget> pages = [
    const ProfilePage(),
    const DiscoverPage(),
    const MessagePage(),
  ];

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.person,
              ),
            label: "Profile",
          ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.my_library_books,
              ),
              label: "Study Together",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.messenger,
              ),
              label: "Messages",
            ),
          ],
      ),
    );
  }
}