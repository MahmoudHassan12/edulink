class DepartmentEntity {
  const DepartmentEntity({this.id, this.name});
  factory DepartmentEntity.fromMap(Map<String, dynamic>? data) =>
      DepartmentEntity(id: data?['id'], name: data?['name']);
  final String? id;
  final String? name;
  Map<String, String?> toMap() => {'id': id, 'name': name};
  bool isValid() => (id?.isNotEmpty ?? false) && (name?.isNotEmpty ?? false);
}
