class UserEntity {
  String? id;
  String? email;
  String? phone;
  String? fullName;
  String? avatar;
  String? password;
  bool? emailVerified;
  bool? phoneVerified;
  List<String?> providers;

  UserEntity({
    this.id,
    this.email,
    this.phone,
    this.fullName,
    this.password,
    this.avatar,
    this.emailVerified,
    this.phoneVerified,
    this.providers = const [],
  });
}
