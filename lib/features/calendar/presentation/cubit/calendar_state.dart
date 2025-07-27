part of 'calendar_cubit.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

final class CalendarInitial extends CalendarState {}

final class CalendarLoading extends CalendarState {}

final class CalendarLoaded extends CalendarState {
  final List<Birthday> birthdays;

  const CalendarLoaded(this.birthdays);

  @override
  List<Object> get props => [birthdays];
}

class CalendarFiltered extends CalendarState {
  final List<Birthday> allBirthdays;
  final List<Birthday> events;
  const CalendarFiltered({required this.allBirthdays, required this.events});

  @override
  List<Object> get props => [allBirthdays, events];
}

final class CalendarError extends CalendarState {
  final String message;

  const CalendarError(this.message);

  @override
  List<Object> get props => [message];
}
