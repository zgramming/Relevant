import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';
import '../../riverpod/global/global_notifier.dart';
import '../home/home_page.dart';
import '../my_account/my_account_page.dart';
import '../my_bookmark/my_bookmark_page.dart';
import '../my_event/my_event_page.dart';

class WelcomePage extends StatefulWidget {
  static const routeNamed = '/welcome-page';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Eventku'),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Favoritku'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
  ];

  final _screens = const [
    HomePage(),
    MyEventPage(),
    MyBookmarkPage(),
    MyAccountPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(12.0),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
        title: Consumer(
          builder: (context, ref, child) {
            final _title = ref.watch(appBarTitle);
            return Text(
              _title,
              style: lato.copyWith(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      // body: const HomePage(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) => BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
            var title = '';
            switch (value) {
              case 0:
                title = 'Dashboard';
                break;
              case 1:
                title = 'EventKu';
                break;
              case 2:
                title = 'BookmarkKu';
                break;
              case 3:
                title = 'ProfileKu';
                break;
              default:
            }
            ref.read(appBarTitle.state).update((state) => title);
          },
          items: _items,
          backgroundColor: primary,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
