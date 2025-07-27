import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../birthdays/domain/entities/birthday.dart';
import '../../../birthdays/domain/usecase/get_all_birthdays_usecase.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final GetAllBirthdaysUseCase getAllBirthdaysUseCase;
  List<Birthday> allBirthdays = [];

  CalendarCubit(this.getAllBirthdaysUseCase) : super(CalendarInitial());

  Future<void> fetchBirthdays() async {
    try {
      emit(CalendarLoading());
      final birthdays = await getAllBirthdaysUseCase();
      allBirthdays = birthdays;
      emit(CalendarLoaded(birthdays));
    } catch (e) {
      emit(CalendarError("Failed to load birthdays: $e"));
    }
  }

  void filterMonthEvents(DateTime month) {
    final events =
        allBirthdays.where((b) => b.birthday.month == month.month).toList();
    emit(CalendarLoaded(events));
  }

  void filterEvents(DateTime date) {
    final events =
        allBirthdays
            .where(
              (b) =>
                  b.birthday.day == date.day && b.birthday.month == date.month,
            )
            .toList();
    emit(CalendarFiltered(allBirthdays: allBirthdays, events: events));
  }
}
