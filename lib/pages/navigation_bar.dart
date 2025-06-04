import 'package:flutter/material.dart';
import 'discover_page.dart';
import 'messages_page.dart';
import 'profile_page.dart';

class NavBar extends StatefulWidget {
  final int index;
  const NavBar({super.key, this.index = 0});

  static route({int i = 0}) => MaterialPageRoute(
    builder: (context) => NavBar(index: i),
  );

  @override
  State<NavBar> createState() => _MainPageState();
}

class _MainPageState extends State<NavBar> {
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.index;
  }

  final List<Widget> pages = [
    DiscoverPage(),
    MessagePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo,
        currentIndex: currentPage,
        onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.school_sharp,
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