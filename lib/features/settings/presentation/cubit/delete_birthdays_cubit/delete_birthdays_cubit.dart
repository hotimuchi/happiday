import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecase/delete_all_birthdays_usecase.dart';

part 'delete_birthdays_state.dart';

class DeleteBirthdaysCubit extends Cubit<DeleteBirthdaysState> {
  final DeleteAllBirthdaysUseCase deleteAllBirthdaysUseCase;

  DeleteBirthdaysCubit(this.deleteAllBirthdaysUseCase)
    : super(DeleteBirthdaysInitial());

  Future<void> deleteBirthdays() async {
    try {
      emit(DeleteBirthdaysLoading());
      await deleteAllBirthdaysUseCase();
      emit(DeleteBirthdaysSuccess());
    } catch (error) {
      emit(DeleteBirthdaysError(error.toString()));
    }
  }
}
