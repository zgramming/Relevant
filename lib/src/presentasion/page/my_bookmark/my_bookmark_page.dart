import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/utils.dart';

import '../../riverpod/event/event_bookmark_notifier.dart';
import '../home/widgets/home_event_for_you_item.dart';

class MyBookmarkPage extends ConsumerWidget {
  const MyBookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(eventBookmarkList);
    if (items.isEmpty) {
      return Center(
        child: Text(
          'Belum ada bookmark nih...',
          style: lato.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(24.0),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = items[index];
        return HomeEventForYouItem(item: item.toEventForYouModel());
      },
    );
  }
}
