import '../repositories/birthday_repository.dart';

class DeleteBirthdayUseCase {
  final BirthdayRepository _repository;

  DeleteBirthdayUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteBirthday(id);
  }
}
