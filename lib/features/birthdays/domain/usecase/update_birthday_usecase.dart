import '../entities/birthday.dart';
import '../repositories/birthday_repository.dart';

class UpdateBirthdayUseCase {
  final BirthdayRepository _repository;

  UpdateBirthdayUseCase(this._repository);

  Future<void> call(Birthday birthday) async {
    await _repository.updateBirthday(birthday);
  }
}
