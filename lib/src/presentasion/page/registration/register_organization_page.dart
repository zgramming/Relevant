import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../data/model/type_organization/type_organization_model.dart';
import '../../../data/model/user/user_register_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/user/user_notifier.dart';
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
        globalNavigation.pushNamedAndRemoveUntil(
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
