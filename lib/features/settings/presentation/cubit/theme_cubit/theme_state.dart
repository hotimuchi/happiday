part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  final bool isDarkMode;
  const ThemeState(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(false);
}

final class ThemeChanged extends ThemeState {
  const ThemeChanged(super.isDarkMode);
}
