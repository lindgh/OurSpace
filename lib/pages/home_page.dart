import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'discover_page.dart';
import 'logIn_page.dart';
import 'message_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const HomePage(),
  );
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {

  final List<Widget> pages = [
    const DiscoverPage(),
    MessagePage(),
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