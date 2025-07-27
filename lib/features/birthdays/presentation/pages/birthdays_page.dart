import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:happiday/features/calendar/presentation/widget/calendar_bottom_sheet.dart';
import 'package:happiday/features/settings/presentation/widget/settings_bottom_sheet.dart';
import 'package:happiday/widget/app_bottom_sheet.dart';

import '../../../../widget/app_widget_text_field.dart';
import '../bloc/birthdays_bloc.dart';
import '../widgets/add_birthday_bottom_sheet.dart';
import '../widgets/view_birthday_bottom_sheet.dart';

class BirthdaysPage extends StatefulWidget {
  const BirthdaysPage({super.key});

  @override
  State<BirthdaysPage> createState() => _BirthdaysPageState();
}

class _BirthdaysPageState extends State<BirthdaysPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    context.read<BirthdaysBloc>().add(LoadBirthdays());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isScrolled = MediaQuery.of(context).size.height > 600;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.surface,
            foregroundColor: theme.onSurface,
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 170.0,
            collapsedHeight: 80.0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 1,
                color: isScrolled ? theme.outline : Colors.transparent,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              expandedTitleScale: 1.0,
              title: Container(
                height: 100.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd(
                        context.locale.toString(),
                      ).format(DateTime.now()),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: theme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(8.0),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        AppWidgetTextField(
                          controller: searchController,
                          hintText: 'search'.tr(),
                          onChanged: (value) {
                            context.read<BirthdaysBloc>().add(
                              SearchBirthdays(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              background: Container(
                padding: const EdgeInsets.only(
                  top: 60.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'app_name'.tr(),
                              style: Theme.of(
                                context,
                              ).textTheme.headlineMedium?.copyWith(
                                color: theme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed:
                                  () => appBottomSheet(
                                    context,
                                    CalendarBottomSheet(),
                                  ),
                              icon: Icon(Icons.calendar_month),
                            ),
                            IconButton(
                              onPressed:
                                  () => appBottomSheet(
                                    context,
                                    SettingsBottomSheet(),
                                  ),
                              icon: Icon(Icons.settings),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<BirthdaysBloc, BirthdaysState>(
            builder: (context, state) {
              if (state is BirthdaysLoading || state is BirthdaysInitial) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is BirthdaysLoaded) {
                if (state.birthdays.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'no_birthdays_found'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: theme.onSurface,
                        ),
                      ),
                    ),
                  );
                }
                final birthdays = state.birthdays.reversed.toList();
                return SliverPadding(
                  padding: const EdgeInsets.only(top: 8, bottom: 120.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final b = birthdays[index];
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
                                      : theme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      );
                    }, childCount: birthdays.length),
                  ),
                );
              }
              if (state is BirthdaysError) {
                return SliverFillRemaining(
                  child: Center(child: Text('Ошибка: ${state.message}')),
                );
              }
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'no_birthdays_found'.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: theme.onSurface),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('add_item'.tr()),
        icon: Icon(Icons.add),
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        onPressed: () {
          appBottomSheet(context, AddBirthdayBottomSheet());
        },
      ),
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
