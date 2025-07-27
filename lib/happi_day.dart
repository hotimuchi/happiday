import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiday/core/theme/app_theme.dart';
import 'package:happiday/routes/routes.dart';

import 'features/settings/presentation/cubit/theme_cubit/theme_cubit.dart';

class HappidayApp extends StatelessWidget {
  const HappidayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state is ThemeChanged ? state.isDarkMode : false;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Happiday',

          // Initialize Easy Localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          // Set the theme
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,

          // Set the initial route
          routerConfig: appRoutes,
        );
      },
    );
  }
}
