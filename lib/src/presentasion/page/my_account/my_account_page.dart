import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import '../../../utils/utils.dart';
import '../create_event/create_event_page.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: primary2,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.person),
                        ),
                        title: Text('Ubah Profil'),
                        trailing: Icon(Icons.chevron_right),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ListTile(
                        onTap: () async {
                          await globalNavigation.pushNamed(routeName: CreateEventPage.routeNamed);
                        },
                        leading: const CircleAvatar(
                          backgroundColor: primary2,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.perm_contact_calendar),
                        ),
                        title: const Text('Buat Event'),
                        subtitle: const Text('Khusus Organisasi'),
                        trailing: const Icon(Icons.chevron_right),
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
