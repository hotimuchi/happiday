part of 'language_cubit.dart';

sealed class LanguageState extends Equatable {
  final Locale? locale;
  const LanguageState(this.locale);

  @override
  List<Object?> get props => [locale];
}

final class LanguageInitial extends LanguageState {
  // ignore: use_super_parameters
  const LanguageInitial(Locale? locale) : super(locale);
}

final class LanguageChanged extends LanguageState {
  // ignore: use_super_parameters
  const LanguageChanged(Locale locale) : super(locale);
}
