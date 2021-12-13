import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/functions/global_function.dart';

import '../../../../../injection.dart';
import '../../../../data/model/event/event_for_you_model.dart';
import '../../../../utils/utils.dart';
import '../../../riverpod/event/event_bookmark_notifier.dart';

class HomeEventForYouBookmark extends ConsumerWidget {
  const HomeEventForYouBookmark({
    required this.item,
  });
  final EventForYouModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final _isAlreadyBookmarked = ref.watch(isAlreadyBookmarked(item.id));
        final _state = ref.watch(eventBookmarkNotifier.select((value) => value.state));
        return InkWell(
          onTap: _state == RequestState.loading
              ? null
              : () async {
                  if (_isAlreadyBookmarked) {
                    /// Remove
                    await ref.read(eventBookmarkNotifier.notifier).delete(item.id);
                  } else {
                    /// Insert
                    await ref.read(eventBookmarkNotifier.notifier).save(item.toBookmarkModel());
                  }

                  final message = ref.read(eventBookmarkNotifier).message;
                  var snackbarType = SnackBarType.normal;
                  if (_state == RequestState.loaded) {
                    snackbarType = SnackBarType.success;
                  }
                  if (_state == RequestState.error) {
                    snackbarType = SnackBarType.error;
                  }

                  Future.delayed(Duration.zero, () {
                    GlobalFunction.showSnackBar(
                      context,
                      content: Text(message),
                      behaviour: SnackBarBehavior.floating,
                      snackBarType: snackbarType,
                    );
                  });
                },
          child: Icon(
            _isAlreadyBookmarked ? Icons.bookmark_sharp : Icons.bookmark_add_outlined,
          ),
        );
      },
    );
  }
}
