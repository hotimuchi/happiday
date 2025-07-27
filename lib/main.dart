import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/list_translation_locale.dart';
import 'core/di/injection_container.dart' as di;
import 'core/di/injection_container.dart';
import 'core/notifications/local_notification_service.dart';
import 'features/birthdays/domain/usecase/get_all_birthdays_usecase.dart';
import 'features/birthdays/presentation/bloc/birthdays_bloc.dart';
import 'features/calendar/presentation/cubit/calendar_cubit.dart';
import 'features/settings/domain/usecase/delete_all_birthdays_usecase.dart';
import 'features/settings/presentation/cubit/delete_birthdays_cubit/delete_birthdays_cubit.dart';
import 'features/settings/presentation/cubit/language_cubit/language_cubit.dart';
import 'features/settings/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'happi_day.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations to portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize dependency injection
  await di.init();

  await sl<LocalNotificationService>().initNotification();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [englishLocale, russianLocale],
      path: 'assets/translations',
      startLocale: englishLocale,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => LanguageCubit()),
          BlocProvider(
            create:
                (context) =>
                    DeleteBirthdaysCubit(sl<DeleteAllBirthdaysUseCase>()),
          ),
          BlocProvider(
            create: (context) => CalendarCubit(sl<GetAllBirthdaysUseCase>()),
          ),
          BlocProvider<BirthdaysBloc>(create: (_) => sl<BirthdaysBloc>()),
        ],
        child: const HappidayApp(),
      ),
    ),
  );
}
