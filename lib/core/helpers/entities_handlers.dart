// List<T>? complexListEntity<T>(
//   List<dynamic>? data,
//   T Function(Map<String, dynamic>?)? fromMap,
// ) => data
//     ?.whereType<Map<String, dynamic>>() // Safely filter only valid maps
//     .map(fromMap ?? (data) => null as T) // Safe fallback
//     .whereType<T>() // Exclude null values from the list
//     .toList();

sealed class ListHandler {
  const ListHandler();
  static List<T>? parseSimple<T>(final List<dynamic>? jsonList) =>
      jsonList?.whereType<T>().toList();

  static List<T>? parseComplex<T>(
    final List<dynamic>? data,
    final T Function(Map<String, dynamic>) fromMap,
  ) => data?.whereType<Map<String, dynamic>>().map<T>(fromMap).toList();

  static List<Map<String, dynamic>>? encodeComplex<T>(
    final List<T>? entities,
    final Map<String, dynamic> Function(T) fromEntity,
  ) => entities?.map(fromEntity).toList();
}
