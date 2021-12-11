import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../../riverpod/event/event_detail_notifier.dart';
import '../widgets/contact_information.dart';

class EventDetailPage extends StatelessWidget {
  static const routeNamed = '/detail-event-page';
  const EventDetailPage({
    Key? key,
    required this.idEvent,
  }) : super(key: key);

  final int idEvent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail Event'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final _future = ref.watch(getEventDetail(idEvent));
          return _future.when(
            data: (_) {
              final event = ref.watch(
                eventDetailNotifier.select((value) => value.item),
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: sizes.height(context) / 4,
                            decoration: const BoxDecoration(
                              color: primary4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  event.title,
                                  style: lato.copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Wrap(
                                    spacing: 10,
                                    children: [
                                      Card(
                                        // ignore: use_named_constants
                                        margin: const EdgeInsets.only(),
                                        color: primary2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            eventTypeToValue[event.type] ?? '',
                                            style: latoWhite.copyWith(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        // ignore: use_named_constants
                                        margin: const EdgeInsets.only(),
                                        color: primary2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            event.namaCategory,
                                            style: latoWhite.copyWith(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  event.namaOrganisasi,
                                  style: latoPrimary.copyWith(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Deskripsi',
                                        style: lato.copyWith(
                                          color: darkGrey400,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.arrow_drop_down),
                                    ),
                                  ],
                                ),
                                Card(
                                  // ignore: use_named_constants
                                  margin: const EdgeInsets.only(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      event.description,
                                      style: lato.copyWith(color: darkGrey),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Relawan Mengikuti',
                                        style: lato.copyWith(
                                          color: darkGrey400,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: primary2,
                                      radius: 15.0,
                                      foregroundColor: Colors.white,
                                      child: FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            GlobalFunction.formatNumber(event.totalJoinedEvent),
                                            style: latoWhite.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: sizes.height(context) / 10,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: event.joinedEvent.length,
                                    itemExtent: 100,
                                    itemBuilder: (context, index) {
                                      final people = event.joinedEvent[index];
                                      return Column(
                                        children: [
                                          const Expanded(
                                            child: CircleAvatar(
                                              backgroundColor: primary3,
                                              radius: 60.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                              horizontal: 8.0,
                                            ),
                                            child: Text(
                                              people.namaRelawan,
                                              maxLines: 1,
                                              style: lato.copyWith(
                                                color: darkGrey400,
                                                fontSize: 8.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Kontak Organisasi',
                                  style: lato.copyWith(
                                    color: darkGrey400,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 20,
                                  children: [
                                    ContactInformation(
                                      onTap: () {},
                                      title: 'WhatsApp',
                                      icon: Icons.phone,
                                      isActive: event.whatsappOrganisasi != null,
                                    ),
                                    ContactInformation(
                                      title: 'Website',
                                      icon: Icons.web,
                                      onTap: () {},
                                      isActive: event.websiteOrganisasi != null,
                                    ),
                                    ContactInformation(
                                      title: 'Instagram',
                                      icon: Icons.social_distance,
                                      onTap: () {},
                                      isActive: event.instagramOrganisasi != null,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    child: ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        primary: primary,
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: Text(
                        'Ikut Event',
                        style: latoWhite.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) => Center(child: Text((error as Failure).message)),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
