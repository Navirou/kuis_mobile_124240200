import 'package:flutter/material.dart';

import 'views/home_page.dart';
import 'views/profile_page.dart';

// [BONUS FAVORITE - IMPORT] Hapus comment di bawah jika ingin mengaktifkan tab Favorite:
import 'views/favorite_page.dart';

class Root extends StatefulWidget {
  final String username;
  const Root({super.key, required this.username});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      // [BONUS FAVORITE - PAGE] Hapus comment di bawah jika ingin menambahkan halaman Favorite:
      const FavoritePage(),
      ProfilePage(username: widget.username),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          // [BONUS FAVORITE - MENU ITEM] Hapus comment di bawah jika ingin menambahkan menu tab Favorite:
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorite'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
