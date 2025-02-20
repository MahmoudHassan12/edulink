class UserEntity {
  const UserEntity({
    this.id,
    this.name,
    this.imageUrl,
    this.email,
    this.phoneNumber,
    this.emailVerified,
    this.isProfessor,
  });
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? email;
  final String? phoneNumber;
  final bool? emailVerified;
  final bool? isProfessor;
}
