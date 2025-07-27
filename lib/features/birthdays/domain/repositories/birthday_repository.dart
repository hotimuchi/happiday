import '../entities/birthday.dart';

abstract class BirthdayRepository {
  Future<List<Birthday>> getAllBirthdays();
  Future<void> addBirthday(Birthday birthday);
  Future<void> updateBirthday(Birthday birthday);
  Future<void> deleteBirthday(String id);
}
