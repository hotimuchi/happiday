import '../repositories/settings_repository.dart';

class DeleteAllBirthdaysUseCase {
  final SettingsRepository repository;

  DeleteAllBirthdaysUseCase(this.repository);

  Future<void> call() async {
    return await repository.deleteAllBirthdays();
  }
}
