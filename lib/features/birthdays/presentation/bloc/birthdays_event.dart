part of 'birthdays_bloc.dart';

abstract class BirthdaysEvent extends Equatable {
  const BirthdaysEvent();

  @override
  List<Object?> get props => [];
}

class LoadBirthdays extends BirthdaysEvent {}

class AddBirthday extends BirthdaysEvent {
  final Birthday birthday;
  const AddBirthday(this.birthday);

  @override
  List<Object?> get props => [birthday];
}

class SearchBirthdays extends BirthdaysEvent {
  final String query;
  const SearchBirthdays(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateBirthday extends BirthdaysEvent {
  final Birthday birthday;
  const UpdateBirthday(this.birthday);

  @override
  List<Object?> get props => [birthday];
}

class DeleteBirthday extends BirthdaysEvent {
  final String id;
  const DeleteBirthday(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteAllBirthdays extends BirthdaysEvent {
  const DeleteAllBirthdays();

  @override
  List<Object?> get props => [];
}
