import 'package:happiday/features/birthdays/domain/entities/birthday.dart';

import '../../db/app_database.dart';

// Из Birthday в BirthdaysTableData (для записи в БД)
extension BirthdayToDatabase on Birthday {
  BirthdaysTableData toDatabase() {
    return BirthdaysTableData(
      id: id,
      name: name,
      birthday: birthday,
      photoUrl: photoUrl,
      phone: phone,
      email: email,
      note: note,
      relation: relation,
      isFavorite: isFavorite,
      timezone: timezone,
    );
  }
}

// Из BirthdaysTableData в Birthday (для работы в домене)
extension BirthdaysTableDataToDomain on BirthdaysTableData {
  Birthday toDomain() {
    return Birthday(
      id: id,
      name: name,
      birthday: birthday,
      photoUrl: photoUrl,
      phone: phone,
      email: email,
      note: note,
      relation: relation,
      isFavorite: isFavorite,
      timezone: timezone,
    );
  }
}
