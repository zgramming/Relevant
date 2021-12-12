import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../../injection.dart';
import '../../../../data/model/event/event_for_you_model.dart';
import '../../../../utils/utils.dart';
import '../../../riverpod/event/event_bookmark_notifier.dart';

class HomeEventForYouBookmark extends StatefulWidget {
  const HomeEventForYouBookmark({
    Key? key,
    required this.item,
  }) : super(key: key);

  final EventForYouModel item;

  @override
  State<HomeEventForYouBookmark> createState() => _HomeEventForYouBookmarkState();
}

class _HomeEventForYouBookmarkState extends State<HomeEventForYouBookmark> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final _isAlreadyBookmarked = ref.watch(isAlreadyBookmarked(widget.item.id));
        return InkWell(
          onTap: () async {
            try {
              var message = '';
              if (_isAlreadyBookmarked) {
                /// Remove
                message = await ref.read(eventBookmarkNotifier.notifier).delete(widget.item.id);
              } else {
                /// Insert

                message = await ref
                    .read(eventBookmarkNotifier.notifier)
                    .save(widget.item.toBookmarkModel());
              }

              if (!mounted) {
                return;
              }

              GlobalFunction.showSnackBar(
                context,
                content: Text(message),
                snackBarType: SnackBarType.info,
              );
            } catch (e, stackTrace) {
              final message = (e as Failure).message;
              log('Message $message || $stackTrace');
              GlobalFunction.showSnackBar(
                context,
                content: Text(message),
                snackBarType: SnackBarType.error,
              );
            }
          },
          child: Icon(
            _isAlreadyBookmarked ? Icons.bookmark_sharp : Icons.bookmark_add_outlined,
          ),
        );
      },
    );
  }
}
