import 'package:flutter/material.dart';
import 'package:relevant/src/presentasion/page/my_event/my_event_page.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/utils.dart';
import '../home/home_page.dart';

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
    Text('bookmar'),
    Text('alun'),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      // body: const HomePage(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() => _selectedIndex = value),
        items: _items,
        backgroundColor: primary,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
