import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../change_password/change_password_page.dart';
import '../create_event/create_event_page.dart';
import '../login/login_page.dart';
import '../update_profile/update_profile_page.dart';

class MyAccountPage extends ConsumerWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifier.select((value) => value.item));
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            // ignore: use_named_constants
            margin: const EdgeInsets.only(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Consumer(
                builder: (context, ref, child) {
                  final user = ref.watch(
                    userNotifier.select((value) => value.item),
                  );

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: primary,
                      radius: 30.0,
                      child: ClipOval(
                        child: Builder(
                          builder: (context) {
                            final imageUrl =
                                user?.type == UserType.relawan ? user?.pictureProfile : user?.logo;
                            return CachedNetworkImage(
                              imageUrl:
                                  '$pathImageUser${imageUrl ?? ''}?v=${DateTime.now().millisecondsSinceEpoch}',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    title: Text(user?.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(user?.type.name ?? ''),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Terakhir update : '),
                              TextSpan(text: GlobalFunction.formatYMDHM(user!.updatedAt!))
                            ],
                          ),
                          style: lato.copyWith(
                            fontSize: 10.0,
                            color: darkGrey400,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: ListTile.divideTiles(
                  tiles: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: primary2,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.person),
                        ),
                        title: const Text('Ubah Profil'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          await globalNavigation.pushNamed(
                            routeName: UpdateProfilePage.routeNamed,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ListTile(
                        onTap: () async {
                          await globalNavigation.pushNamed(
                            routeName: ChangePasswordPage.routeNamed,
                          );
                        },
                        leading: const CircleAvatar(
                          backgroundColor: primary2,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.lock),
                        ),
                        title: const Text('Ubah Password'),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                    if (user?.type == UserType.organisasi)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: primary2,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.perm_contact_calendar),
                          ),
                          title: const Text('Buat Event'),
                          subtitle: const Text('Khusus Organisasi'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            await globalNavigation.pushNamed(routeName: CreateEventPage.routeNamed);
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Consumer(
                        builder: (context, ref, child) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: primary2,
                              foregroundColor: Colors.white,
                              child: Icon(Icons.logout_rounded),
                            ),
                            title: const Text('Keluar'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () async {
                              try {
                                await ref.read(userNotifier.notifier).logout();
                                await globalNavigation.pushNamedAndRemoveUntil(
                                  routeName: LoginPage.routeNamed,
                                  predicate: (route) => false,
                                );
                              } catch (e, stackTrace) {
                                log('error ${(e as Failure).message} || $stackTrace');
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                  color: darkGrey400,
                  context: context,
                ).toList(),
              ),
            ),
          ),
          Card(
            // ignore: use_named_constants
            margin: const EdgeInsets.only(),
            color: primary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CopyRightVersion(
                copyRight:
                    'UAS Teknologi Web Service Semester 5\nCopyright ${GlobalFunction.formatY(DateTime.now())} \u00a9 Universitas Bina Sarana Informatika',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
