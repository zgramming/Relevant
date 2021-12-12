import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/event/event_nearest_date_model.dart';
import '../../../../utils/utils.dart';
import '../../event_detail/event_detail_page.dart';

class HomeEventNearestDateItem extends StatelessWidget {
  const HomeEventNearestDateItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final EventNearestDateModel item;

  @override
  Widget build(BuildContext context) {
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
              child: Builder(
                builder: (context) {
                  if (item.image == null) {
                    return Container(color: primary);
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: pathImageEvent + item.image!,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                },
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
  }
}
