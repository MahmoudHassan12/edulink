T? complexEntity<T>(
  Map<String, dynamic>? data,
  T Function(Map<String, dynamic>?)? fromMap,
) => data == null ? null : fromMap?.call(data);

List<T>? complexListEntity<T>(
  List<Map<String, dynamic>>? data,
  T Function(Map<String, dynamic>?)? fromMap,
) => data?.map(fromMap ?? (data) => <T>[] as T).toList();
