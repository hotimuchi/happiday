import '../entities/birthday.dart';
import '../repositories/birthday_repository.dart';

class AddBirthdayUseCase {
  final BirthdayRepository _repository;

  AddBirthdayUseCase(this._repository);

  Future<void> call(Birthday birthday) async {
    await _repository.addBirthday(birthday);
  }
}
