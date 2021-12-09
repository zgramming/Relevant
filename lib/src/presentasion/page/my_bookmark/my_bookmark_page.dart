import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import '../../../utils/utils.dart';

class MyBookmarkPage extends StatelessWidget {
  const MyBookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(24.0),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: 100,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
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
                            const Icon(Icons.bookmark_add_outlined),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Title Loremp Ipsum',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 10),
                              const SizedBox(width: 5),
                              Text(
                                GlobalFunction.formatYMDHM(DateTime.now()),
                                style: lato.copyWith(
                                  fontSize: 8.0,
                                ),
                              ),
                            ],
                          ),
                        ),
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
