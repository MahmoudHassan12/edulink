class ProgramEntity {
  const ProgramEntity({this.id, this.departmentId, this.name});
  factory ProgramEntity.fromMap(Map<String, dynamic>? data) => ProgramEntity(
    id: data?['id'],
    departmentId: data?['department_id'],
    name: data?['name'],
  );
  final String? id;
  final String? departmentId;
  final String? name;
  Map<String, String?> toMap() => {
    'id': id,
    'department_id': departmentId,
    'name': name,
  };
  bool get isValid =>
      (id?.isNotEmpty ?? false) &&
      (departmentId?.isNotEmpty ?? false) &&
      (name?.isNotEmpty ?? false);
}
