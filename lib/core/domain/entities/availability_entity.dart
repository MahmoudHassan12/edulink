import 'package:edu_link/core/domain/entities/available_time_entity.dart';
import 'package:edu_link/core/helpers/entities_handlers.dart';

class AvailabilityEntity {
  const AvailabilityEntity({this.times});

  factory AvailabilityEntity.fromMap(Map<String, dynamic>? data) =>
      AvailabilityEntity(
        times: ListHandler.parseComplex(
          data?['times'],
          AvailableTimeEntity.fromMap,
        ),
      );

  final List<AvailableTimeEntity>? times;

  AvailabilityEntity copyWith({List<AvailableTimeEntity>? times}) =>
      AvailabilityEntity(times: times ?? this.times);

  Map<String, List<Map<String, dynamic>>?> toMap() => {
    'times': times?.map((time) => time.toMap()).toList(),
  };

  AvailabilityEntity setAvailableTime(AvailableTimeEntity availableTime) =>
      AvailabilityEntity(times: times?..add(availableTime));
}
