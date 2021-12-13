import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../../riverpod/event/event_for_you_notifier.dart';
import '../../riverpod/event/event_nearest_date_notifier.dart';
import 'widgets/home_event_for_you_item.dart';
import 'widgets/home_event_nearest_date_item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

                      if (items.isEmpty) {
                        return const Center(child: Text('Belum ada event yang tedekat nih...'));
                      }

                      return ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        itemExtent: sizes.width(context) / 1.2,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return HomeEventNearestDateItem(item: item);
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

                    if (items.isEmpty) {
                      return const Center(child: Text('Belum ada event untuk kamu nih...'));
                    }

                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemCount: items.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return HomeEventForYouItem(item: item);
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
