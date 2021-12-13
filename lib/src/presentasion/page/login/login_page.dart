import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../registration/register_organization_page.dart';
import '../registration/register_volunteer_page.dart';
import '../welcome/welcome_page.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                              final _state = ref.watch(
                                userNotifier.select(
                                  (value) => value.state,
                                ),
                              );

                              return ElevatedButton(
                                onPressed: _state == RequestState.loading
                                    ? null
                                    : () async {
                                        await ref.read(userNotifier.notifier).login(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );

                                        if (_state == RequestState.loaded) {
                                          await globalNavigation.pushNamedAndRemoveUntil(
                                            routeName: WelcomePage.routeNamed,
                                            predicate: (route) => false,
                                          );
                                        } else if (_state == RequestState.error) {
                                          final message = ref.read(userNotifier).message;
                                          Future.delayed(Duration.zero, () {
                                            GlobalFunction.showSnackBar(
                                              context,
                                              content: Text(message),
                                              behaviour: SnackBarBehavior.floating,
                                              snackBarType: SnackBarType.error,
                                            );
                                          });
                                        }
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
                                    onPressed: () async => globalNavigation.pushNamed(
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
                                    onPressed: () async => globalNavigation.pushNamed(
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
            // Positioned.fill(
            //   child: Consumer(builder: (context, ref, child) {
            //     final result = ref.watch(getEventDetail2);
            //     return result.when(
            //       data: (data) => Center(
            //         child: LinearProgressIndicator(),
            //       ),
            //       error: (error, stackTrace) => Center(child: Text(error.toString())),
            //       loading: () => Center(child: CircularProgressIndicator()),
            //     );
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
