import '../../domain/entities/birthday.dart';

class BirthdayModel {
  final String id;
  final String name;
  final DateTime birthday;
  final String? photoUrl;
  final String? phone;
  final String? email;
  final String? note;
  final String? relation;
  final bool? isFavorite;
  final String? timezone;

  BirthdayModel({
    required this.id,
    required this.name,
    required this.birthday,
    this.photoUrl,
    this.phone,
    this.email,
    this.note,
    this.relation,
    this.isFavorite,
    this.timezone,
  });

  factory BirthdayModel.fromEntity(Birthday entity) => BirthdayModel(
    id: entity.id,
    name: entity.name,
    birthday: entity.birthday,
    photoUrl: entity.photoUrl,
    phone: entity.phone,
    email: entity.email,
    note: entity.note,
    relation: entity.relation,
    isFavorite: entity.isFavorite,
    timezone: entity.timezone,
  );

  Birthday toEntity() => Birthday(
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
