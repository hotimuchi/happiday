part of 'delete_birthdays_cubit.dart';

sealed class DeleteBirthdaysState extends Equatable {
  const DeleteBirthdaysState();

  @override
  List<Object> get props => [];
}

final class DeleteBirthdaysInitial extends DeleteBirthdaysState {}

final class DeleteBirthdaysLoading extends DeleteBirthdaysState {}

final class DeleteBirthdaysSuccess extends DeleteBirthdaysState {}

final class DeleteBirthdaysError extends DeleteBirthdaysState {
  final String message;

  const DeleteBirthdaysError(this.message);

  @override
  List<Object> get props => [message];
}
