class Birthday {
  final String id; // Уникальный идентификатор (может быть uuid)
  final String name; // Имя пользователя
  final DateTime birthday; // Дата рождения
  final String? photoUrl; // Ссылка на фото (аватар)
  final String? phone; // Телефон (для смс/звонка)
  final String? email; // E-mail (для поздравления)
  final String? note; // Дополнительная заметка (например, любимый подарок)
  final String? relation; // Родство (друг, семья, коллега и т.д.)
  final bool? isFavorite; // Флаг "избранный"
  final String? timezone;

  Birthday({
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

  Birthday copyWith({
    String? id,
    String? name,
    DateTime? birthday,
    String? photoUrl,
    String? phone,
    String? email,
    String? note,
    String? relation,
    bool? isFavorite,
    String? timezone,
  }) {
    return Birthday(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      photoUrl: photoUrl ?? this.photoUrl,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      note: note ?? this.note,
      relation: relation ?? this.relation,
      isFavorite: isFavorite ?? this.isFavorite,
      timezone: timezone ?? this.timezone,
    );
  }
}
