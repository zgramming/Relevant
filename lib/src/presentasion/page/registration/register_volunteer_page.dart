import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_register_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/user/user_notifier.dart';
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
    ref.listen<UserState>(userNotifier, (previous, next) {
      if (next.actionState == RequestState.error) {
        GlobalFunction.showSnackBar(
          context,
          behaviour: SnackBarBehavior.floating,
          content: Text(next.message),
          snackBarType: SnackBarType.error,
        );
      } else if (next.actionState == RequestState.loaded) {
        globalNavigation.pushNamedAndRemoveUntil(
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
                final actionState = ref.watch(
                  userNotifier.select((value) => value.actionState),
                );

                return ElevatedButton(
                  onPressed: actionState == RequestState.loading
                      ? null
                      : () async {
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
