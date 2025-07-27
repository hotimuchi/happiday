import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/list_translation_locale.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static const _localeKey = 'localeCode';

  LanguageCubit() : super(LanguageInitial(englishLocale)) {
    loadLocale();
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey) ?? 'en';
    emit(LanguageChanged(Locale(code)));
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
    emit(LanguageChanged(locale));
  }
}
