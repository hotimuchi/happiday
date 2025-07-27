import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Map<DateTime, List<dynamic>> events;
  final void Function(DateTime, DateTime)? onDaySelected;

  const Calendar({
    super.key,
    required this.focusedDay,
    this.selectedDay,
    required this.events,
    this.onDaySelected,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay;
  }

  void _showCupertinoMonthYearPicker() {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => Container(
            height: 250,
            color: Theme.of(context).colorScheme.surface,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _focusedDay,
              minimumDate: DateTime(2000, 1),
              maximumDate: DateTime(2100, 12),
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _focusedDay = DateTime(newDate.year, newDate.month, 1);
                });
              },
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: _showCupertinoMonthYearPicker,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: theme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_focusedDay.month.toString().padLeft(2, '0')} ${'months_short'.tr()} ${_focusedDay.year} ${'years_short'.tr()}',
                      ),
                      const Gap(8),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: theme.primary,
                        size: 38,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(1900, 1, 1),
              lastDay: DateTime.utc(2200, 12, 31),
              focusedDay: _focusedDay,
              headerVisible: false,
              daysOfWeekVisible: true,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: theme.onSurface.withValues(alpha: 0.5),
                ),
                weekendStyle: TextStyle(
                  color: theme.primary.withValues(alpha: 0.5),
                ),
              ),
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              selectedDayPredicate:
                  (day) =>
                      widget.selectedDay != null &&
                      day.day == widget.selectedDay!.day &&
                      day.month == widget.selectedDay!.month &&
                      day.year == widget.selectedDay!.year,
              eventLoader: (day) {
                final key = DateTime(0, day.month, day.day);
                return widget.events[key] ?? [];
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
              onDaySelected: widget.onDaySelected,
              locale: Localizations.localeOf(context).languageCode,
            ),
          ],
        ),
      ),
    );
  }
}
