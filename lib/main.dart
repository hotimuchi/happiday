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
import 'startup_error_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? errorText;
  try {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await di.init();
    await sl<LocalNotificationService>().initNotification();
    await EasyLocalization.ensureInitialized();
  } catch (e, s) {
    errorText = 'Startup error: $e';
    debugPrint(errorText);
    debugPrint(s.toString());
  }
  runApp(
    errorText == null
        ? EasyLocalization(
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
                create:
                    (context) => CalendarCubit(sl<GetAllBirthdaysUseCase>()),
              ),
              BlocProvider<BirthdaysBloc>(create: (_) => sl<BirthdaysBloc>()),
            ],
            child: const HappidayApp(),
          ),
        )
        : MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StartupErrorScreen(errorText: errorText),
        ),
  );
}
