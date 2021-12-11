import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:relevant/src/presentasion/riverpod/event/event_for_you_notifier.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../../riverpod/event/event_nearest_date_notifier.dart';
import '../widgets/contact_information.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Event Waktu Terdekat',
              style: latoPrimary.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: sizes.height(context) / 4.5,
              child: Consumer(
                builder: (context, ref, child) {
                  final _future = ref.watch(getNearestDateEvent);
                  return _future.when(
                    data: (data) {
                      final items = ref.watch(
                        eventNearestDateNotifier.select((value) => value.items),
                      );
                      return ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        itemExtent: sizes.width(context) / 1.2,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: InkWell(
                                    onTap: () async {
                                      await globalNavigation.pushNamed(
                                        routeName: DetailEventPage.routeNamed,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.5),
                                      borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                      item.title,
                                      style: latoWhite.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => Center(child: Text((error as Failure).message)),
                    loading: () => const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Event Untuk Kamu',
              style: latoPrimary.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final _future = ref.watch(getEventForYou);
                return _future.when(
                  data: (data) {
                    final items = ref.watch(
                      eventForYouNotifier.select((value) => value.items),
                    );

                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemCount: items.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          // ignore: use_named_constants
                          margin: const EdgeInsets.only(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(color: primary),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Wrap(
                                                  spacing: 10,
                                                  children: [
                                                    Card(
                                                      color: primary,
                                                      // ignore: use_named_constants
                                                      margin: const EdgeInsets.only(),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                          eventTypeToValue[item.type] ?? '',
                                                          style: latoWhite.copyWith(
                                                            fontSize: 8.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Card(
                                                      color: primary,
                                                      // ignore: use_named_constants
                                                      margin: const EdgeInsets.only(),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                          item.namaCategory,
                                                          style: latoWhite.copyWith(
                                                            fontSize: 8.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Icon(Icons.bookmark_add_outlined),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            item.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_today,
                                                size: 10,
                                                color: darkGrey400,
                                              ),
                                              const SizedBox(width: 5),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: GlobalFunction.formatYMD(
                                                        item.startDate,
                                                        format: FormatYMD.completed,
                                                      ),
                                                    ),
                                                    const TextSpan(text: ' - '),
                                                    TextSpan(
                                                      text: GlobalFunction.formatYMD(
                                                        item.endDate,
                                                        format: FormatYMD.completed,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                style: lato.copyWith(
                                                  fontSize: 8.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: darkGrey400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.timer,
                                                size: 10,
                                                color: darkGrey400,
                                              ),
                                              const SizedBox(width: 5),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: GlobalFunction.formatHM(
                                                        item.startDate,
                                                      ),
                                                    ),
                                                    const TextSpan(text: ' - '),
                                                    TextSpan(
                                                      text: GlobalFunction.formatHM(
                                                        item.endDate,
                                                      ),
                                                    ),
                                                    const TextSpan(text: ' '),
                                                    TextSpan(
                                                      text:
                                                          "(${item.endDate.difference(item.startDate).inMinutes}) menit",
                                                    ),
                                                  ],
                                                ),
                                                style: lato.copyWith(
                                                  fontSize: 8.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: darkGrey400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) => Center(child: Text((error as Failure).message)),
                  loading: () => Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailEventPage extends StatelessWidget {
  static const routeNamed = '/detail-event-page';
  const DetailEventPage({Key? key}) : super(key: key);

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
      body: Column(
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
                          'Lorem Ipsum title',
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
                                    'Online',
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
                                    'Pendidikan',
                                    style: latoWhite.copyWith(fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'PT. Cinta Kasih Sekolah.inc',
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
                              // ignore: leading_newlines_in_multiline_strings
                              """Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
                              """,
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
                                    '200',
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
                            itemCount: 10,
                            itemExtent: 100,
                            itemBuilder: (context, index) => const CircleAvatar(
                              backgroundColor: primary3,
                            ),
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
                          children: const [
                            ContactInformation(title: 'WhatsApp', icon: Icons.phone),
                            ContactInformation(title: 'Website', icon: Icons.web),
                            ContactInformation(title: 'Instagram', icon: Icons.social_distance),
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
      ),
    );
  }
}
