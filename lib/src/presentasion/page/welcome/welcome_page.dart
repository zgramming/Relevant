import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const routeNamed = '/welcome-page';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome Page'),
      ),
    );
  }
}
