import 'package:flutter/material.dart' show TimeOfDay;

class AvailableTimeEntity {
  const AvailableTimeEntity({this.day, this.from, this.to});

  factory AvailableTimeEntity.fromMap(Map<String, dynamic>? data) {
    final from = data?['from'] as Map<String, dynamic>?;
    final to = data?['to'] as Map<String, dynamic>?;
    return AvailableTimeEntity(
      day: data?['day'],
      from:
          from != null
              ? TimeOfDay(hour: from['hour'] ?? 0, minute: from['minute'] ?? 0)
              : null,
      to:
          to != null
              ? TimeOfDay(hour: to['hour'] ?? 0, minute: to['minute'] ?? 0)
              : null,
    );
  }

  final String? day;
  final TimeOfDay? from;
  final TimeOfDay? to;

  Map<String, dynamic> toMap() => {
    'day': day,
    'from': from != null ? {'hour': from!.hour, 'minute': from!.minute} : null,
    'to': to != null ? {'hour': to!.hour, 'minute': to!.minute} : null,
  };
}
