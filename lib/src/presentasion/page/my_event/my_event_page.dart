import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../injection.dart';
import '../../../utils/utils.dart';
import '../../riverpod/event/my_event_notifier.dart';
import '../home/widgets/home_event_for_you_item.dart';
import '../widgets/modal_bottomsheet_indicator.dart';

class MyEventPage extends ConsumerStatefulWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  _MyEventPageState createState() => _MyEventPageState();
}

class _MyEventPageState extends ConsumerState<MyEventPage> {
  DateTime _focusedDay = DateTime.now().subtract(const Duration(days: 10));
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(myEventNotifier),
      child: SingleChildScrollView(
        child: SizedBox(
          height: sizes.screenHeightMinusAppBarAndStatusBar(context),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),
                  child: TableCalendar(
                    focusedDay: _focusedDay,
                    currentDay: _focusedDay,
                    firstDay: DateTime(2010),
                    lastDay: DateTime(2100),
                    calendarFormat: CalendarFormat.month,
                    locale: 'id_ID',
                    rowHeight: sizes.height(context) / 10,
                    eventLoader: (day) => ref.watch(myEventByDay(day)),
                    // availableCalendarFormats: {
                    //   CalendarFormat.month: 'Bulan',
                    //   CalendarFormat.twoWeeks: '2 Minggu',
                    //   CalendarFormat.week: 'Seminggu',
                    // },
                    daysOfWeekStyle: DaysOfWeekStyle(
                      // decoration: BoxDecoration(color: Colors.blue),

                      weekendStyle: lato.copyWith(
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),

                    headerStyle: HeaderStyle(
                      decoration: BoxDecoration(
                        color: primary2,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
                      rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
                      titleTextStyle: latoWhite.copyWith(fontWeight: FontWeight.bold),
                      headerMargin: const EdgeInsets.only(bottom: 32.0),
                    ),
                    onDaySelected: (selectedDay, focusedDay) async {
                      setState(() {
                        _focusedDay = selectedDay;
                      });

                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        builder: (context) => ModalMyEvent(date: selectedDay),
                      );
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                      ref
                          .read(myEventQuery.state)
                          .update((state) => state.copyWith(dateTime: focusedDay));
                    },
                  ),
                ),
              ),
              Positioned.fill(
                child: Consumer(
                  builder: (context, ref, child) {
                    final _future = ref.watch(getMyEvent);
                    return _future.when(
                      data: (data) => const SizedBox.shrink(),
                      error: (error, stackTrace) => Center(child: Text((error as Failure).message)),
                      loading: () => const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModalMyEvent extends StatelessWidget {
  const ModalMyEvent({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: sizes.height(context) / 1.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const ModalBottomSheetIndicator(),
          Flexible(
            child: Consumer(
              builder: (context, ref, child) {
                final items = ref.watch(myEventByDay(date));

                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HomeEventForYouItem(item: item.toEventForYouModel()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
