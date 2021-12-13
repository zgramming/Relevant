import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../injection.dart';
import '../../../data/model/event/event_bookmark_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/event/event_bookmark_notifier.dart';
import '../../riverpod/event/event_detail_notifier.dart';
import '../widgets/contact_information.dart';

class EventDetailPage extends ConsumerWidget {
  static const routeNamed = '/detail-event-page';
  const EventDetailPage({
    Key? key,
    required this.idEvent,
  }) : super(key: key);

  final int idEvent;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _future = ref.watch(getEventDetail(idEvent));
    return _future.when(
      data: (_) {
        final event = ref.watch(
          eventDetailNotifier.select((value) => value.item),
        );

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Detail Event'),
            actions: [
              Consumer(
                builder: (context, ref, child) {
                  final _isAlreadyBookmarked = ref.watch(isAlreadyBookmarked(idEvent));
                  final _state = ref.watch(eventBookmarkNotifier.select((value) => value.state));
                  return IconButton(
                    onPressed: () async {
                      if (_isAlreadyBookmarked) {
                        /// Remove
                        await ref.read(eventBookmarkNotifier.notifier).delete(idEvent);
                      } else {
                        /// Insert
                        final model = EventBookmarkModel(
                          id: event.id,
                          title: event.title,
                          startDate: DateTime.now(),
                          endDate: DateTime.now(),
                          type: event.type,
                          quota: 0,
                          image: event.image,
                          namaCategory: event.namaCategory,
                          namaOrganisasi: event.namaOrganisasi,
                          idUser: ref.read(userNotifier).item?.id ?? 0,
                        );
                        await ref.read(eventBookmarkNotifier.notifier).save(model);
                      }

                      final message = ref.read(eventBookmarkNotifier).message;

                      var snackbarType = SnackBarType.normal;

                      if (_state == RequestState.loaded) {
                        snackbarType = SnackBarType.success;
                      }

                      if (_state == RequestState.error) {
                        snackbarType = SnackBarType.error;
                      }

                      Future.delayed(
                        Duration.zero,
                        () => GlobalFunction.showSnackBar(
                          context,
                          content: Text(message),
                          snackBarType: snackbarType,
                          behaviour: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: Icon(
                      _isAlreadyBookmarked ? Icons.bookmark_sharp : Icons.bookmark_add_outlined,
                    ),
                  );
                },
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
                        child: Builder(
                          builder: (context) {
                            if (event.image == null) {
                              return Center(
                                child: Text(
                                  'No Image',
                                  style: latoWhite.copyWith(fontWeight: FontWeight.bold),
                                ),
                              );
                            }

                            return CachedNetworkImage(
                              imageUrl: pathImageEvent + event.image!,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              event.title,
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
                                        eventTypeToValue[event.type] ?? '',
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
                                        event.namaCategory,
                                        style: latoWhite.copyWith(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              event.namaOrganisasi,
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
                                  event.description,
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
                                        GlobalFunction.formatNumber(event.totalJoinedEvent),
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
                              child: event.joinedEvent.isEmpty
                                  ? const Center(
                                      child: Text('Jadilah yang pertama untuk menjadi relawan...'),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: event.joinedEvent.length,
                                      itemExtent: 100,
                                      itemBuilder: (context, index) {
                                        final people = event.joinedEvent[index];
                                        return Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: sizes.width(context) / 8,
                                                width: sizes.width(context) / 8,
                                                decoration: BoxDecoration(
                                                  color: primary2,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 2.0,
                                                      color: darkGrey.withOpacity(.5),
                                                    ),
                                                  ],
                                                ),
                                                child: Builder(
                                                  builder: (_) {
                                                    if (people.profileRelawan == null) {
                                                      return Center(
                                                        child: FittedBox(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              'No Image',
                                                              style: latoWhite,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return ClipOval(
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            pathImageUser + people.profileRelawan!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                                horizontal: 8.0,
                                              ),
                                              child: Text(
                                                people.namaRelawan,
                                                maxLines: 1,
                                                style: lato.copyWith(
                                                  color: darkGrey400,
                                                  fontSize: 8.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
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
                              children: [
                                ContactInformation(
                                  onTap: () {},
                                  title: 'WhatsApp',
                                  icon: Icons.phone,
                                  isActive: event.whatsappOrganisasi != null,
                                ),
                                ContactInformation(
                                  title: 'Website',
                                  icon: Icons.web,
                                  onTap: () {},
                                  isActive: event.websiteOrganisasi != null,
                                ),
                                ContactInformation(
                                  title: 'Instagram',
                                  icon: Icons.social_distance,
                                  onTap: () {},
                                  isActive: event.instagramOrganisasi != null,
                                ),
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
              if (event.isEventExpired) ...[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: darkGrey400,
                    ),
                    child: Text(
                      'Event sudah lewat',
                      style: latoPrimary.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final _state = ref.watch(
                        eventDetailNotifier.select((value) => value.state),
                      );
                      return ElevatedButton(
                        onPressed: _state == RequestState.loading
                            ? null
                            : () async {
                                final idUser = ref.read(userNotifier).item?.id ?? 0;
                                await ref.read(eventDetailNotifier.notifier).joinEvent(
                                      idEvent: idEvent,
                                      idUser: idUser,
                                    );

                                final message = ref.read(eventDetailNotifier).message;
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
                        style: ElevatedButton.styleFrom(
                          primary: primary,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: Text(
                          event.isAlreadyJoinEvent ? 'Batalkan Ikut' : 'Ikut Event',
                          style: latoWhite.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]
            ],
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(body: Center(child: Text((error as Failure).message))),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
