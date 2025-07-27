part of 'birthdays_bloc.dart';

abstract class BirthdaysState extends Equatable {
  const BirthdaysState();

  @override
  List<Object?> get props => [];
}

class BirthdaysInitial extends BirthdaysState {}

class BirthdaysLoading extends BirthdaysState {}

class BirthdaysLoaded extends BirthdaysState {
  final List<Birthday> birthdays;
  const BirthdaysLoaded(this.birthdays);

  @override
  List<Object?> get props => [birthdays];
}

class BirthdaysError extends BirthdaysState {
  final String message;
  const BirthdaysError(this.message);

  @override
  List<Object?> get props => [message];
}
