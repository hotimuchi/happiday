import '../entities/birthday.dart';
import '../repositories/birthday_repository.dart';

class GetAllBirthdaysUseCase {
  final BirthdayRepository _repository;

  GetAllBirthdaysUseCase(this._repository);

  Future<List<Birthday>> call() async {
    return await _repository.getAllBirthdays();
  }
}
