import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../../riverpod/event/event_for_you_notifier.dart';
import '../../riverpod/event/event_nearest_date_notifier.dart';
import '../event_detail/event_detail_page.dart';

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
                                        routeName: EventDetailPage.routeNamed,
                                        arguments: item.id,
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
                  loading: () => const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
