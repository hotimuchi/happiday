import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'core/constants/list_translation_locale.dart';
import 'core/di/injection_container.dart';
import 'core/notifications/local_notification_service.dart';
import 'features/birthdays/presentation/bloc/birthdays_bloc.dart';
import 'features/calendar/presentation/cubit/calendar_cubit.dart';
import 'features/settings/presentation/cubit/delete_birthdays_cubit/delete_birthdays_cubit.dart';
import 'features/settings/presentation/cubit/language_cubit/language_cubit.dart';
import 'features/settings/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'happi_day.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await init();
  await sl<LocalNotificationService>().initNotification();
  await EasyLocalization.ensureInitialized();

  // Получаем текущий часовой пояс устройства
  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.initializeTimeZones();

  // Определяем стартовую локаль по часовому поясу
  Locale startLocale = englishLocale;
  if (currentTimeZone.contains('Europe/Moscow') ||
      currentTimeZone.contains('Asia/Yekaterinburg') ||
      currentTimeZone.contains('Asia/Novosibirsk') ||
      currentTimeZone.contains('Europe/Samara')) {
    startLocale = russianLocale;
  }

  runApp(
    EasyLocalization(
      supportedLocales: [englishLocale, russianLocale],
      path: 'assets/translations',
      startLocale: startLocale,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<ThemeCubit>()),
          BlocProvider(create: (_) => sl<LanguageCubit>()),
          BlocProvider(create: (_) => sl<DeleteBirthdaysCubit>()),
          BlocProvider(create: (_) => sl<CalendarCubit>()),
          BlocProvider(create: (_) => sl<BirthdaysBloc>()),
        ],
        child: const HappidayApp(),
      ),
    ),
  );
}
