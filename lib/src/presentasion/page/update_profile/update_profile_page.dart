import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_model.dart';
import '../../../data/model/user/user_update_form_model.dart';
import '../../../utils/utils.dart';
import '../widgets/form_content.dart';
import '../widgets/modal_pick_image.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  static const routeNamed = '/update-profile-page';
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  late final TextEditingController nameController;
  late final TextEditingController birthDateController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController websiteController;
  late final TextEditingController whatsappContactController;
  late final TextEditingController emailContactController;
  late final TextEditingController instagramContactController;

  File? _selectedPictureProfile;
  File? _selectedLogo;

  DateTime? _selectedBirthDate;

  late final User _user;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userNotifier).item;
    _user = user!;

    nameController = TextEditingController(text: user.name);
    birthDateController = TextEditingController(
      text: user.birthDate == null
          ? ''
          : GlobalFunction.formatYMD(
              user.birthDate!,
              format: FormatYMD.completed,
            ),
    );
    phoneController = TextEditingController(text: user.phone ?? '');
    addressController = TextEditingController(text: '${user.address}');
    websiteController = TextEditingController(text: '${user.website}');
    whatsappContactController = TextEditingController(text: '${user.whatsappContact}');
    emailContactController = TextEditingController(text: '${user.emailContact}');
    instagramContactController = TextEditingController(text: '${user.instagramContact}');

    _selectedBirthDate = _user.birthDate;
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    addressController.dispose();
    websiteController.dispose();
    whatsappContactController.dispose();
    emailContactController.dispose();
    instagramContactController.dispose();
    super.dispose();
  }

  Column _formRelawan(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormContent(
          title: 'Tanggal Lahir',
          child: TextFormFieldCustom(
            controller: birthDateController,
            disableOutlineBorder: false,
            readOnly: true,
            onTap: () async {
              final _birthDate = await GlobalFunction.showDateTimePicker(
                context,
                withTimePicker: false,
              );
              if (_birthDate != null) {
                setState(() {
                  _selectedBirthDate = _birthDate;
                  birthDateController.text = GlobalFunction.formatYMD(
                    _birthDate,
                    format: FormatYMD.completed,
                  );
                });
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        FormContent(
          title: 'Nomor Telepon',
          child: TextFormFieldCustom(
            controller: phoneController,
            disableOutlineBorder: false,
            keyboardType: TextInputType.phone,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (context) => ModalBottomPickImage(
                              onPickImage: (file) {
                                if (_user.type == UserType.relawan) {
                                  _selectedPictureProfile = file;
                                } else {
                                  _selectedLogo = file;
                                }
                                setState(() {});
                              },
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(60.0),
                        child: Ink(
                          height: sizes.width(context) / 3.5,
                          width: sizes.width(context) / 3.5,
                          decoration: BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: darkGrey.withOpacity(.5),
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Builder(
                            builder: (context) {
                              /// Order for show image
                              /// 1. From File Device
                              /// 2. From Network Image
                              if (_selectedLogo != null) {
                                return ClipOval(
                                  child: Image.file(File(_selectedLogo!.path), fit: BoxFit.cover),
                                );
                              }

                              if (_selectedPictureProfile != null) {
                                return ClipOval(
                                  child: Image.file(
                                    File(_selectedPictureProfile!.path),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }

                              if (_user.type == UserType.relawan && _user.pictureProfile != null) {
                                return ClipOval(
                                  child: CachedNetworkImage(
                                    key: ValueKey(_user.pictureProfile),
                                    imageUrl:
                                        '$pathImageUser${_user.pictureProfile!}?v=${DateTime.now().millisecondsSinceEpoch}',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }

                              if (_user.type == UserType.organisasi && _user.logo != null) {
                                return ClipOval(
                                  child: CachedNetworkImage(
                                    key: ValueKey(_user.pictureProfile),
                                    imageUrl:
                                        '$pathImageUser${_user.logo!}?v=${DateTime.now().millisecondsSinceEpoch}',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }

                              return const Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Nama Lengkap',
                      child: TextFormFieldCustom(
                        controller: nameController,
                        disableOutlineBorder: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_user.type == UserType.relawan) ...[
                      _formRelawan(context),
                    ] else ...[
                      _formOrganisasi(),
                    ]
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer(
              builder: (context, ref, child) {
                final onUpdateState = ref.watch(
                  userNotifier.select((value) => value.actionUpdateState),
                );
                return ElevatedButton(
                  onPressed: onUpdateState == RequestState.loading
                      ? null
                      : () async {
                          try {
                            if (_selectedBirthDate == null) {
                              throw const CommonFailure('Tanggal lahir wajib diisi');
                            }
                            final model = UserUpdateFormModel(
                              id: _user.id,
                              birthDate: _selectedBirthDate!,
                              type: _user.type,
                              phone: phoneController.text,
                              address: addressController.text,
                              website: websiteController.text,
                              emailContact: emailContactController.text,
                              instagramContact: instagramContactController.text,
                              logo: _selectedLogo,
                              name: nameController.text,
                              pictureProfile: _selectedPictureProfile,
                              whatsappContact: whatsappContactController.text,
                            );

                            await ref.read(userNotifier.notifier).update(model);

                            if (!mounted) return;

                            GlobalFunction.showSnackBar(
                              context,
                              content: const Text('Berhasil update user'),
                            );
                          } catch (e, stackTrace) {
                            final message = (e as Failure).message;
                            log('error $message || stacktrace $stackTrace');
                            GlobalFunction.showSnackBar(
                              context,
                              content: Text(message),
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

  Column _formOrganisasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormContent(
          title: 'Alamat',
          child: TextFormFieldCustom(
            controller: addressController,
            disableOutlineBorder: false,
          ),
        ),
        const SizedBox(height: 20),
        FormContent(
          title: 'Website',
          child: TextFormFieldCustom(
            controller: websiteController,
            disableOutlineBorder: false,
          ),
        ),
        const SizedBox(height: 20),
        FormContent(
          title: 'Whatsapp',
          child: TextFormFieldCustom(
            controller: whatsappContactController,
            disableOutlineBorder: false,
          ),
        ),
        const SizedBox(height: 20),
        FormContent(
          title: 'Kontak Email',
          child: TextFormFieldCustom(
            controller: emailContactController,
            disableOutlineBorder: false,
          ),
        ),
        const SizedBox(height: 20),
        FormContent(
          title: 'Instagram',
          child: TextFormFieldCustom(
            controller: instagramContactController,
            disableOutlineBorder: false,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
