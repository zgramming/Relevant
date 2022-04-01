import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentasion/page/change_password/change_password_page.dart';
import 'presentasion/page/create_event/create_event_page.dart';
import 'presentasion/page/event_detail/event_detail_page.dart';
import 'presentasion/page/login/login_page.dart';
import 'presentasion/page/registration/register_organization_page.dart';
import 'presentasion/page/registration/register_volunteer_page.dart';
import 'presentasion/page/splash/splash_page.dart';
import 'presentasion/page/update_profile/update_profile_page.dart';
import 'presentasion/page/welcome/welcome_page.dart';
import 'utils/utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();
    return MaterialApp(
      title: 'Relevant',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      // supportedLocales: const [Locale('id', 'ID')],
      navigatorKey: navigatorKey,
      theme: theme.copyWith(
        primaryColor: primary,
        colorScheme: theme.colorScheme.copyWith(secondary: secondary),
        appBarTheme: const AppBarTheme(color: primary),
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashPage(),
      onGenerateRoute: (settings) {
        final route = RouteAnimation();

        switch (settings.name) {
          case LoginPage.routeNamed:
            return route.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => const LoginPage(),
            );
          case RegisterVolunteerPage.routeNamed:
            return route.slideTransition(
              screen: (ctx, animation, secondaryAnimation) => const RegisterVolunteerPage(),
            );

          case RegisterOrganizationPage.routeNamed:
            return route.slideTransition(
              screen: (ctx, animation, secondaryAnimation) => const RegisterOrganizationPage(),
            );

          case WelcomePage.routeNamed:
            return route.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => const WelcomePage(),
            );

          case CreateEventPage.routeNamed:
            return route.slideTransition(
              screen: (ctx, animation, secondaryAnimation) => const CreateEventPage(),
              slidePosition: SlidePosition.fromLeft,
            );
          case EventDetailPage.routeNamed:
            final idEvent = settings.arguments! as int;
            return route.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => EventDetailPage(idEvent: idEvent),
            );

          case UpdateProfilePage.routeNamed:
            return route.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => const UpdateProfilePage(),
            );

          case ChangePasswordPage.routeNamed:
            return route.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => const ChangePasswordPage(),
            );

          default:
          // return SizedBox();
        }
        return null;
      },
    );
  }
}
