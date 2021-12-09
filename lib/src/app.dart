import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';

import '../injection.dart';
import 'data/model/type_organization/type_organization_model.dart';
import 'data/model/user/user_register_model.dart';
import 'presentasion/riverpod/user/user_notifier.dart';
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
      supportedLocales: const [Locale('id', 'ID')],
      navigatorKey: navigatorKey,
      theme: theme.copyWith(
        primaryColor: primary,
        colorScheme: theme.colorScheme.copyWith(secondary: secondary),
        appBarTheme: const AppBarTheme(color: primary),
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home: const WelcomePage(),
      onGenerateRoute: (settings) {
        final route = RouteAnimation();

        switch (settings.name) {
          case LoginPage.routeNamed:
            return route.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => const LoginPage(),
            );
          case RegisterVolunteerPage.routeNamed:
            return route.slideTransition(
                screen: (ctx, animation, secondaryAnimation) => const RegisterVolunteerPage());

          case RegisterOrganizationPage.routeNamed:
            return route.slideTransition(
                screen: (ctx, animation, secondaryAnimation) => const RegisterOrganizationPage());

          case WelcomePage.routeNamed:
            return route.fadeTransition(
                screen: (ctx, animation, secondaryAnimation) => const WelcomePage());

          default:
          // return SizedBox();
        }
      },
    );
  }
}

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
      () => GlobalNavigation.pushNamed(routeName: LoginPage.routeNamed),
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

class LoginPage extends ConsumerStatefulWidget {
  static const routeNamed = '/login-page';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserState>(userNotifier, (previous, next) {
      if (next.state == RequestState.error) {
        GlobalFunction.showSnackBar(
          context,
          behaviour: SnackBarBehavior.floating,
          content: Text(next.message),
          snackBarType: SnackBarType.error,
        );
      } else if (next.state == RequestState.loaded) {
        GlobalNavigation.pushNamedAndRemoveUntil(
          routeName: WelcomePage.routeNamed,
          predicate: (route) => false,
        );
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: primary)),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: latoWhite.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        TextFormFieldCustom(
                          controller: emailController,
                          disableOutlineBorder: false,
                          prefixIcon: const Icon(Icons.email),
                          hintText: 'john.doe@gmail.com',
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          controller: passwordController,
                          disableOutlineBorder: false,
                          isPassword: true,
                          hintText: '********',
                        ),
                        const SizedBox(height: 20),
                        Consumer(
                          builder: (context, ref, child) {
                            return ElevatedButton(
                              onPressed: () async {
                                await ref.read(userNotifier.notifier).login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                primary: primary,
                              ),
                              child: Text(
                                'Login',
                                style: latoWhite.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          },
                        ),
                        KeyboardVisibilityBuilder(
                          builder: (context, child, isKeyboardVisible) {
                            if (isKeyboardVisible) {
                              return const SizedBox();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'Belum punya akun ?',
                                  style: latoPrimary.copyWith(fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                OutlinedButton(
                                  onPressed: () async => GlobalNavigation.pushNamed(
                                    routeName: RegisterVolunteerPage.routeNamed,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12.0),
                                    side: const BorderSide(color: secondary),
                                  ),
                                  child: Text(
                                    'Daftar sebagai relawan',
                                    style: latoSecondary.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Atau',
                                  style: latoSecondary.copyWith(fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5),
                                OutlinedButton(
                                  onPressed: () async => GlobalNavigation.pushNamed(
                                    routeName: RegisterOrganizationPage.routeNamed,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12.0),
                                    side: const BorderSide(color: secondary),
                                  ),
                                  child: Text(
                                    'Daftar sebagai Organisasi',
                                    style: latoSecondary.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterVolunteerPage extends ConsumerStatefulWidget {
  static const routeNamed = '/register-volunteer-page';

  const RegisterVolunteerPage({Key? key}) : super(key: key);

  @override
  _RegisterVolunteerPageState createState() => _RegisterVolunteerPageState();
}

class _RegisterVolunteerPageState extends ConsumerState<RegisterVolunteerPage> {
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserState>(userNotifier, (previous, next) {
      if (next.state == RequestState.error) {
        GlobalFunction.showSnackBar(
          context,
          behaviour: SnackBarBehavior.floating,
          content: Text(next.message),
          snackBarType: SnackBarType.error,
        );
      } else if (next.state == RequestState.loaded) {
        GlobalNavigation.pushNamedAndRemoveUntil(
          routeName: WelcomePage.routeNamed,
          predicate: (route) => false,
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Relawan'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormContent(
                      title: 'Nama Lengkap',
                      textFormFieldCustom: TextFormFieldCustom(
                        controller: fullnameController,
                        disableOutlineBorder: false,
                        hintText: 'Zeffry Reynando',
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Email',
                      textFormFieldCustom: TextFormFieldCustom(
                        controller: emailController,
                        disableOutlineBorder: false,
                        hintText: 'zeffry.reynando@gmail.com',
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Password',
                      textFormFieldCustom: TextFormFieldCustom(
                        controller: passwordController,
                        disableOutlineBorder: false,
                        hintText: '********',
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Konfirmasi Password',
                      textFormFieldCustom: TextFormFieldCustom(
                        controller: passwordConfirmationController,
                        disableOutlineBorder: false,
                        hintText: '********',
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: ElevatedButton(
              onPressed: () async {
                final model = UserRegisterModel(
                  name: fullnameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  passwordConfirmation: passwordConfirmationController.text,
                  userType: UserType.relawan,
                );

                await ref.read(userNotifier.notifier).register(model);
              },
              style: ElevatedButton.styleFrom(
                primary: primary,
                padding: const EdgeInsets.all(16.0),
              ),
              child: Text(
                'Register',
                style: latoWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormContent extends StatelessWidget {
  const FormContent({
    Key? key,
    required this.textFormFieldCustom,
    required this.title,
  }) : super(key: key);

  final TextFormFieldCustom textFormFieldCustom;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: lato.copyWith(fontSize: 16.0),
        ),
        const SizedBox(height: 10),
        textFormFieldCustom,
      ],
    );
  }
}

class RegisterOrganizationPage extends ConsumerStatefulWidget {
  static const routeNamed = '/register-organization-page';

  const RegisterOrganizationPage({Key? key}) : super(key: key);

  @override
  _RegisterOrganizationPageState createState() => _RegisterOrganizationPageState();
}

class _RegisterOrganizationPageState extends ConsumerState<RegisterOrganizationPage> {
  final nameOrganizationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final addressController = TextEditingController();

  TypeOrganization? _selectedTypeOrganization;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(typeOrganizationNotifier.notifier).get());
  }

  @override
  void dispose() {
    nameOrganizationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserState>(userNotifier, (previous, next) {
      if (next.state == RequestState.error) {
        GlobalFunction.showSnackBar(
          context,
          behaviour: SnackBarBehavior.floating,
          content: Text(next.message),
          snackBarType: SnackBarType.error,
        );
      } else if (next.state == RequestState.loaded) {
        // GlobalFunction.showSnackBar(context, content: Text('success'));
        GlobalNavigation.pushNamedAndRemoveUntil(
          routeName: WelcomePage.routeNamed,
          predicate: (route) => false,
        );
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrasi Organisasi'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormContent(
                        title: 'Nama Organisasi',
                        textFormFieldCustom: TextFormFieldCustom(
                          controller: nameOrganizationController,
                          disableOutlineBorder: false,
                          hintText: 'Zeffry Reynando',
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Email',
                        textFormFieldCustom: TextFormFieldCustom(
                          controller: emailController,
                          disableOutlineBorder: false,
                          hintText: 'organisasi.inc@gmail.com',
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Password',
                        textFormFieldCustom: TextFormFieldCustom(
                          controller: passwordController,
                          disableOutlineBorder: false,
                          hintText: '********',
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Konfirmasi Password',
                        textFormFieldCustom: TextFormFieldCustom(
                          controller: passwordConfirmationController,
                          disableOutlineBorder: false,
                          hintText: '********',
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Consumer(
                        builder: (context, ref, child) {
                          final items =
                              ref.watch(typeOrganizationNotifier.select((value) => value.items));
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Tipe Organisasi',
                                style: lato.copyWith(fontSize: 16.0),
                              ),
                              const SizedBox(height: 10),
                              DropdownFormFieldCustom<TypeOrganization>(
                                items: items,
                                itemBuilder: (item) => Text('${item?.name}'),
                                onChanged: (item) => _selectedTypeOrganization = item,
                                labelText: '',
                                hint: const Text('Pilih Tipe Organisasi'),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Alamat',
                        textFormFieldCustom: TextFormFieldCustom(
                          controller: addressController,
                          disableOutlineBorder: false,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 3,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: ElevatedButton(
                onPressed: () async {
                  final model = UserRegisterModel(
                    name: nameOrganizationController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    passwordConfirmation: passwordConfirmationController.text,
                    userType: UserType.organisasi,
                    idTypeOrganization: _selectedTypeOrganization?.id,
                    address: addressController.text,
                  );

                  await ref.read(userNotifier.notifier).register(model);
                },
                style: ElevatedButton.styleFrom(
                  primary: primary,
                  padding: const EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Register',
                  style: latoWhite.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
