import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/utils.dart';

class MyEventPage extends StatelessWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2010),
        lastDay: DateTime.now(),
        calendarFormat: CalendarFormat.month,
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
        locale: 'id_ID',
        onDaySelected: (selectedDay, focusedDay) => GlobalFunction.showSnackBar(
          context,
          content: Text(GlobalFunction.formatYMDHMS(focusedDay)),
        ),
        onPageChanged: (focusedDay) => log('focus $focusedDay'),
        rowHeight: sizes.height(context) / 10,
      ),
    );
  }
}
