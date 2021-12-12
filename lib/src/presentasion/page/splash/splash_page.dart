import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../../riverpod/user/user_notifier.dart';
import '../login/login_page.dart';
import '../welcome/welcome_page.dart';

class SplashPage extends ConsumerWidget {
  static const routeNamed = '/splash-page';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<UserState>(userNotifier, (previous, next) {
      if (next.item == null) {
        globalNavigation.pushNamedAndRemoveUntil(
          routeName: LoginPage.routeNamed,
          predicate: (route) => false,
        );
      } else {
        globalNavigation.pushNamedAndRemoveUntil(
          routeName: WelcomePage.routeNamed,
          predicate: (route) => false,
        );
      }
    });
    return Scaffold(
      backgroundColor: primary,
      body: Consumer(
        builder: (context, ref, child) {
          final _initialize = ref.watch(_initializeApplication);

          return _initialize.when(
            data: (data) => const SizedBox(),
            error: (error, stackTrace) => Center(child: Text((error as Failure).message)),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

final _initializeApplication = FutureProvider.autoDispose((ref) async {
  /// Initialize Bookmark
  ref.watch(eventBookmarkNotifier.notifier).initialize();

  /// Initialize user should be last to initialize
  /// Because after this initialize, we should be navigate to [login/welcome] pages
  await ref.watch(userNotifier.notifier).initializeUser();

  return true;
});
