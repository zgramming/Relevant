import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  static const routeNamed = '/splash-page';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () => globalNavigation.pushNamed(routeName: LoginPage.routeNamed),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primary,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
