final class QueryEntity {
  const QueryEntity({
    this.limit,
    this.orderBy,
    this.descending = false,
    this.fields,
  });
  final int? limit;
  final String? orderBy;
  final bool descending;
  final List<FieldEntity>? fields;
}

final class FieldEntity {
  const FieldEntity({
    required this.field,
    this.isEqualTo,
    this.isNotEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.whereNotIn,
    this.isNull,
  });

  final String field;
  final Object? isEqualTo;
  final Object? isNotEqualTo;
  final Object? isLessThan;
  final Object? isLessThanOrEqualTo;
  final Object? isGreaterThan;
  final Object? isGreaterThanOrEqualTo;
  final Object? arrayContains;
  final Iterable<Object>? arrayContainsAny;
  final Iterable<Object>? whereIn;
  final Iterable<Object>? whereNotIn;
  final bool? isNull;
}
