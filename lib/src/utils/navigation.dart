import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class GlobalNavigation {
  static Future<void> pushNamed({
    required String routeName,
    Object? arguments,
  }) async {
    await navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<void> pushNamedAndRemoveUntil({
    required String routeName,
    required bool Function(Route<dynamic> route) predicate,
    Object? arguments,
  }) async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  static void popUntill({
    required bool Function(Route<dynamic> route) predicate,
  }) {
    navigatorKey.currentState?.popUntil(predicate);
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }
}
