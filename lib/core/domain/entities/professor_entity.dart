class ProfessorEntity {
  const ProfessorEntity({this.id, this.name, this.imageUrl});

  factory ProfessorEntity.fromMap(Map<String, dynamic>? data) {
    if (data == null) return const ProfessorEntity();
    return ProfessorEntity(
      name: data['name'] ?? "N/A",
      imageUrl: data['imageUrl'],
    );
  }
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? email;
  final String? phoneNumber;
  final bool? emailVerified;
  final bool? isProfessor;
}
