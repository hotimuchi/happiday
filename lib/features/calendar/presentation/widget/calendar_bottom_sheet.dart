import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../widget/app_bottom_sheet.dart';
import '../../../birthdays/domain/entities/birthday.dart';
import '../../../birthdays/presentation/widgets/view_birthday_bottom_sheet.dart';
import '../cubit/calendar_cubit.dart';

class CalendarBottomSheet extends StatefulWidget {
  const CalendarBottomSheet({super.key});

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = null;
    final cubit = context.read<CalendarCubit>();
    cubit.fetchBirthdays().then((_) {
      cubit.filterMonthEvents(focusedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        List<Birthday> allBirthdays = [];
        if (state is CalendarLoaded) {
          allBirthdays = state.birthdays;
        } else if (state is CalendarFiltered) {
          allBirthdays = state.allBirthdays;
        }

        Map<DateTime, List<Birthday>> eventsMap = {};
        for (final b in allBirthdays) {
          final key = DateTime(0, b.birthday.month, b.birthday.day);
          eventsMap.putIfAbsent(key, () => []).add(b);
        }

        return Container(
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'calendar'.tr(),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              TableCalendar<Birthday>(
                firstDay: DateTime.utc(1900, 1, 1),
                lastDay: DateTime.utc(2200, 12, 31),
                focusedDay: focusedDay,

                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: theme.onSurface,
                    fontSize: 20,
                  ),
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleTextFormatter:
                      (date, locale) => DateFormat.yMMMM(
                        context.locale.toString(),
                      ).format(date),
                ),

                daysOfWeekVisible: true,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: theme.onSurface.withValues(alpha: 0.5),
                  ),
                  weekendStyle: TextStyle(
                    color: theme.primary.withValues(alpha: 0.5),
                  ),
                  dowTextFormatter: (date, locale) {
                    return DateFormat.EEEEE(locale.toString()).format(date);
                  },
                ),

                onRangeSelected: (start, end, focusedDay) {
                  setState(() {
                    this.focusedDay = focusedDay;
                    selectedDay = start ?? end;
                  });
                  context.read<CalendarCubit>().filterEvents(selectedDay!);
                },

                selectedDayPredicate:
                    (day) =>
                        selectedDay != null &&
                        day.day == selectedDay!.day &&
                        day.month == selectedDay!.month,
                eventLoader: (day) {
                  final key = DateTime(0, day.month, day.day);
                  return eventsMap[key] ?? [];
                },

                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isNotEmpty) {
                      return Positioned(
                        bottom: 8,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: theme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),

                calendarStyle: CalendarStyle(
                  holidayTextStyle: TextStyle(color: theme.primary),
                  todayTextStyle: TextStyle(color: theme.primary),
                  defaultTextStyle: TextStyle(color: theme.onSurface),
                  outsideDaysVisible: false,
                  disabledTextStyle: TextStyle(
                    color: theme.onSurface.withValues(alpha: 0.5),
                  ),

                  selectedDecoration: BoxDecoration(
                    color: theme.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),

                onDaySelected: (selected, focused) {
                  setState(() {
                    selectedDay = selected;
                    focusedDay = focused;
                  });
                  context.read<CalendarCubit>().filterEvents(selected);
                },

                onPageChanged: (focusedDay) {
                  setState(() {
                    this.focusedDay = focusedDay;
                  });
                  context.read<CalendarCubit>().filterMonthEvents(focusedDay);
                },

                locale: context.locale.languageCode,
              ),
              Divider(height: 1, color: theme.onSurface.withValues(alpha: 0.1)),
              Expanded(
                child: BlocBuilder<CalendarCubit, CalendarState>(
                  builder: (context, state) {
                    List<Birthday> events = [];
                    if (state is CalendarLoaded) {
                      events = state.birthdays;
                    } else if (state is CalendarFiltered) {
                      events = state.events;
                    }
                    if (events.isEmpty) {
                      return Center(child: Text('no_birthdays'.tr()));
                    }
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final b = events[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: theme.surface,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: theme.onSurface.withValues(alpha: 0.5),
                                blurRadius: 1.0,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              onTap:
                                  () => appBottomSheet(
                                    context,
                                    ViewBirthdayBottomSheet(birthday: b),
                                  ),
                              title: Text(b.name),
                              subtitle: Text(
                                buildBirthdaySubtitle(b.birthday, context),
                              ),
                              trailing: Icon(
                                Icons.notes,
                                color:
                                    b.note != null && b.note!.isNotEmpty
                                        ? theme.primary
                                        : theme.onSurface.withValues(
                                          alpha: 0.5,
                                        ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String buildBirthdaySubtitle(DateTime birthday, BuildContext context) {
    final now = DateTime.now();
    int years = now.year - birthday.year;
    int months = now.month - birthday.month;
    int days = now.day - birthday.day;

    if (days < 0) {
      months -= 1;
      final prevMonth = DateTime(now.year, now.month, 0);
      days += prevMonth.day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    final dateStr = DateFormat.yMMMMd(
      context.locale.toString(),
    ).format(birthday);

    String ageStr = '';
    if (years > 0) ageStr += '$years ${'years_short'.tr()} ';
    if (months > 0) ageStr += '$months ${'months_short'.tr()} ';
    if (days > 0 || ageStr.isEmpty) ageStr += '$days ${'days_short'.tr()}';
    return '$dateStr\n-\n$ageStr';
  }
}
