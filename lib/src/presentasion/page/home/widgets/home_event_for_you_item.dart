import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import '../../../../data/model/event/event_for_you_model.dart';
import '../../../../utils/utils.dart';
import '../../event_detail/event_detail_page.dart';
import 'home_event_for_you_bookmark.dart';

class HomeEventForYouItem extends StatelessWidget {
  const HomeEventForYouItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final EventForYouModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        globalNavigation.pushNamed(
          routeName: EventDetailPage.routeNamed,
          arguments: item.id,
        );
      },
      child: SizedBox(
        height: sizes.height(context) / 5.5,
        child: Card(
          // ignore: use_named_constants
          margin: const EdgeInsets.only(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (item.image == null) {
                        return Container(
                          decoration: const BoxDecoration(color: primary),
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: pathImageEvent + item.image!,
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      );
                    },
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
                            HomeEventForYouBookmark(item: item),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Row(
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
                        ),
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
      ),
    );
  }
}
