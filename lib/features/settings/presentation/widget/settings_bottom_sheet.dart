import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/list_translation_locale.dart';
import '../../../../widget/app_widget_snackbar.dart';
import '../../../birthdays/presentation/bloc/birthdays_bloc.dart';
import '../cubit/delete_birthdays_cubit/delete_birthdays_cubit.dart';
import '../cubit/language_cubit/language_cubit.dart';
import '../cubit/theme_cubit/theme_cubit.dart';
import 'settings_card.dart';
import 'notification_time_card.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'settings'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  SettingsCard(
                    icon: Icons.dark_mode_rounded,
                    title: 'dark_mode',
                    subtitle: 'switch_between_light_and_dark_theme',
                    trailing: BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        final isDarkMode =
                            state is ThemeChanged ? state.isDarkMode : false;

                        return Switch.adaptive(
                          value: isDarkMode,
                          onChanged: (value) {
                            context.read<ThemeCubit>().setTheme(value);
                          },
                        );
                      },
                    ),
                  ),
                  NotificationTimeCard(),
                  SettingsCard(
                    icon: Icons.language_rounded,
                    title: 'select_language',
                    subtitle: 'choose_your_preferred_language',

                    trailing: BlocBuilder<LanguageCubit, LanguageState>(
                      builder: (context, state) {
                        final currentLocale = state.locale ?? englishLocale;
                        return DropdownButton<Locale>(
                          value:
                              currentLocale.languageCode == 'en'
                                  ? englishLocale
                                  : russianLocale,
                          items: [
                            DropdownMenuItem(
                              value: englishLocale,
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: russianLocale,
                              child: Text('Русский'),
                            ),
                          ],
                          onChanged: (code) {
                            if (code != null) {
                              context.read<LanguageCubit>().setLocale(code);
                              context.setLocale(code);
                            }
                          },
                          borderRadius: BorderRadius.circular(10),
                          isDense: true,
                          underline: Container(),
                          style: Theme.of(context).textTheme.bodyLarge,
                          dropdownColor: theme.surface,
                          icon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: theme.onSurface,
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(8),
                  BlocListener<DeleteBirthdaysCubit, DeleteBirthdaysState>(
                    listener: (context, state) {
                      if (state is DeleteBirthdaysSuccess) {
                        context.pop();
                        try {
                          context.read<BirthdaysBloc>().add(LoadBirthdays());
                        } catch (e) {
                          appWidgetSnackBar(
                            context,
                            theme.error,
                            'birthdays_reloaded'.tr(),
                          );
                        }
                      } else if (state is DeleteBirthdaysError) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline_rounded,
                                    color: CupertinoColors.systemRed,
                                    size: 20,
                                  ),
                                  Gap(8),
                                  Text('error'.tr()),
                                ],
                              ),
                              content: Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text('no_birthdays_to_delete'.tr()),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () => context.pop(),
                                  child: Text('ok'.tr()),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: BlocBuilder<
                      DeleteBirthdaysCubit,
                      DeleteBirthdaysState
                    >(
                      builder: (context, state) {
                        return SettingsCard(
                          title: 'remove_birthdays',
                          icon: Icons.delete_forever_rounded,
                          subtitle: 'remove_all_birthdays',
                          trailing:
                              state is DeleteBirthdaysLoading
                                  ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : null,
                          onTap:
                              state is DeleteBirthdaysLoading
                                  ? null
                                  : () {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text('remove_birthdays'.tr()),
                                          content: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              'remove_all_birthdays'.tr(),
                                            ),
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              onPressed: () => context.pop(),
                                              child: Text('cancel'.tr()),
                                            ),
                                            CupertinoDialogAction(
                                              isDestructiveAction: true,
                                              onPressed: () {
                                                context
                                                    .read<
                                                      DeleteBirthdaysCubit
                                                    >()
                                                    .deleteBirthdays();
                                                context.pop();
                                              },
                                              child: Text('confirm'.tr()),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                        );
                      },
                    ),
                  ),
                  const Gap(8),
                  SettingsCard(
                    icon: Icons.info_outline_rounded,
                    title: 'about_app',
                    subtitle: 'about_app_description',
                  ),
                  SettingsCard(title: '', trailing: Text("1.0.0")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
