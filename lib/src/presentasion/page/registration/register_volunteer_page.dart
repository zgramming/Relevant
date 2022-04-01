import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_register_form_model.dart';
import '../../../utils/utils.dart';
import '../welcome/welcome_page.dart';
import '../widgets/form_content.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                        child: TextFormFieldCustom(
                          controller: fullnameController,
                          disableOutlineBorder: false,
                          hintText: 'Zeffry Reynando',
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Email',
                        child: TextFormFieldCustom(
                          controller: emailController,
                          disableOutlineBorder: false,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'zeffry.reynando@gmail.com',
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Password',
                        child: TextFormFieldCustom(
                          controller: passwordController,
                          disableOutlineBorder: false,
                          hintText: '********',
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Konfirmasi Password',
                        child: TextFormFieldCustom(
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
              child: Consumer(
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
                            final model = UserRegisterFormModel(
                              name: fullnameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              passwordConfirmation: passwordConfirmationController.text,
                              userType: UserType.relawan,
                            );

                            await ref.read(userNotifier.notifier).register(model);
                            final notifier = ref.read(userNotifier);

                            if (notifier.state == RequestState.loaded) {
                              await globalNavigation.pushNamedAndRemoveUntil(
                                routeName: WelcomePage.routeNamed,
                                predicate: (route) => false,
                              );
                            } else if (notifier.state == RequestState.error) {
                              Future.delayed(Duration.zero, () {
                                GlobalFunction.showSnackBar(
                                  context,
                                  content: Text(notifier.message),
                                  behaviour: SnackBarBehavior.floating,
                                  snackBarType: SnackBarType.error,
                                );
                              });
                            }
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
