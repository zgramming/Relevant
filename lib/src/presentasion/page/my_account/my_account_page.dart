import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: primary2,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.lock),
                        ),
                        title: Text('Ubah Password'),
                        trailing: Icon(Icons.chevron_right),
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
                                ref.read(userNotifier.notifier).logout();
                                globalNavigation.pushNamedAndRemoveUntil(
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
