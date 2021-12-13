import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../data/model/type_organization/type_organization_model.dart';
import '../../../data/model/user/user_register_form_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/type_organization/type_organization_notifier.dart';
import '../welcome/welcome_page.dart';
import '../widgets/form_content.dart';

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
                        child: TextFormFieldCustom(
                          controller: nameOrganizationController,
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
                          hintText: 'organisasi.inc@gmail.com',
                          keyboardType: TextInputType.emailAddress,
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
                      Consumer(
                        builder: (context, ref, child) {
                          final _future = ref.watch(futureGetTypeOrganization);
                          return _future.when(
                            data: (_) {
                              final items = ref.watch(
                                typeOrganizationNotifier.select(
                                  (value) => value.items,
                                ),
                              );
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
                            error: (error, stackTrace) => Center(
                              child: Text((error as Failure).message),
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      FormContent(
                        title: 'Alamat',
                        child: TextFormFieldCustom(
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final _state = ref.watch(
                    userNotifier.select((value) => value.state),
                  );
                  return ElevatedButton(
                    onPressed: _state == RequestState.loading
                        ? null
                        : () async {
                            final model = UserRegisterFormModel(
                              name: nameOrganizationController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              passwordConfirmation: passwordConfirmationController.text,
                              userType: UserType.organisasi,
                              idTypeOrganization: _selectedTypeOrganization?.id,
                              address: addressController.text,
                            );

                            await ref.read(userNotifier.notifier).register(model);

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
