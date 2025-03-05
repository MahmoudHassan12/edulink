T? complexEntity<T>(
  Map<String, dynamic>? data,
  T Function(Map<String, dynamic>?)? fromMap,
) => data == null ? null : fromMap?.call(data);
List<T>? complexListEntity<T>(
  List<dynamic>? data,
  T Function(Map<String, dynamic>?)? fromMap,
) =>
    data
        ?.whereType<Map<String, dynamic>>() // Safely filter only valid maps
        .map(fromMap ?? (data) => null as T) // Safe fallback
        .whereType<T>() // Exclude null values from the list
        .toList();
