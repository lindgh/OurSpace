import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'discover_page.dart';
import 'logIn_page.dart';
import 'message_page.dart';
import 'profile_page.dart';


class NavBar extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const NavBar(),
  );
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _MainPageState();
}

class _MainPageState extends State<NavBar> {

  final List<Widget> pages = [
    const DiscoverPage(),
    const MessagePage(),
    const ProfilePage(),
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
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.my_library_books,
              ),
              label: "Study Together",
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.messenger,
              ),
              label: "Messages",
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
      ),
    );
  }
}