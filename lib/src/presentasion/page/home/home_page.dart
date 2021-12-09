import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import '../../../utils/utils.dart';

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
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemExtent: sizes.width(context) / 1.2,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10),
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
                            color: Colors.blue.withOpacity(.5),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Lorem Ipsum malala Lorem Ipsum malala Lorem Ipsum malala ',
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Event Pilihan',
              style: latoPrimary.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: 100,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.only(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(color: primary),
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
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Card(
                                          color: primary,
                                          // ignore: use_named_constants
                                          margin: const EdgeInsets.only(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              'Tipe Event',
                                              style: latoWhite.copyWith(
                                                fontSize: 8.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.bookmark_add_outlined),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Title Loremp Ipsum',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 10),
                                    SizedBox(width: 5),
                                    Text(
                                      GlobalFunction.formatYMDHM(
                                        DateTime.now(),
                                      ),
                                      style: lato.copyWith(
                                        fontSize: 8.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
