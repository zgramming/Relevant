import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_change_password_form_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/user/user_notifier.dart';
import '../widgets/form_content.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  static const routeNamed = '/change-password-page';
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordConfirmationController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordConfirmationController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserState>(userNotifier, (previous, next) {
      if (next.actionChangePasswordState == RequestState.loaded) {
        GlobalFunction.showSnackBar(
          context,
          content: const Text('Berhasil ubah password'),
          snackBarType: SnackBarType.success,
        );
        globalNavigation.pop();
      }

      if (next.actionChangePasswordState == RequestState.error) {
        GlobalFunction.showSnackBar(
          context,
          content: Text(next.message),
          snackBarType: SnackBarType.error,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormContent(
                        title: 'Password Lama',
                        child: TextFormFieldCustom(
                          controller: oldPasswordController,
                          disableOutlineBorder: false,
                          isPassword: true,
                          hintText: '********',
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Password Baru',
                        child: TextFormFieldCustom(
                          controller: newPasswordController,
                          disableOutlineBorder: false,
                          isPassword: true,
                          hintText: '********',
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Konfirmasi Password',
                        child: TextFormFieldCustom(
                          controller: newPasswordConfirmationController,
                          disableOutlineBorder: false,
                          isPassword: true,
                          hintText: '********',
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Consumer(
              builder: (context, ref, child) {
                final _changePasswordState = ref.watch(
                  userNotifier.select((value) => value.actionChangePasswordState),
                );
                return ElevatedButton(
                  onPressed: _changePasswordState == RequestState.loading
                      ? null
                      : () async {
                          final validate = _formKey.currentState?.validate() ?? false;
                          if (!validate) {
                            return;
                          }
                          try {
                            final _user = ref.read(userNotifier).item;

                            final model = UserChangePasswordFormModel(
                              idUser: _user?.id ?? 0,
                              newPassword: newPasswordController.text,
                              oldPassword: oldPasswordController.text,
                              newPasswordConfirmation: newPasswordConfirmationController.text,
                            );
                            await ref.read(userNotifier.notifier).changePassword(model: model);
                          } catch (e, stackTrace) {
                            log('error $e || stackTract $stackTrace');
                            GlobalFunction.showSnackBar(
                              context,
                              content: Text(e.toString()),
                              snackBarType: SnackBarType.error,
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    primary: primary,
                    padding: const EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'Update',
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
