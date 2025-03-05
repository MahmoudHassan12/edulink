class DurationEntity {
  const DurationEntity({this.hours = 0, this.minutes = 0, this.seconds = 0});

  /// Creates a `DurationEntity` from a Firestore map
  factory DurationEntity.fromMap(Map<String, dynamic>? data) {
    if (data == null) return const DurationEntity();
    return DurationEntity(
      hours: (data['hours'] as num?)?.toInt() ?? 0,
      minutes: (data['minutes'] as num?)?.toInt() ?? 0,
      seconds: (data['seconds'] as num?)?.toInt() ?? 0,
    );
  }

  /// Converts the `DurationEntity` to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {'hours': hours, 'minutes': minutes, 'seconds': seconds};
  }

  final int hours;
  final int minutes;
  final int seconds;
}
