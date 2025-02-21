class DurationEntity {
  const DurationEntity({this.hours, this.minutes, this.seconds});

  factory DurationEntity.fromMap(Map<String, dynamic>? data) {
    if (data == null) return const DurationEntity();
    return DurationEntity(
      hours: data['hours'] ?? "0",
      minutes: data['minutes'] ?? "0",
      seconds: data['seconds'] ?? "0",
    );
  }
  final int? hours;
  final int? minutes;
  final int? seconds;
}
