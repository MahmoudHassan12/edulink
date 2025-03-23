import 'package:edu_link/core/domain/entities/availability_entity.dart';
import 'package:edu_link/core/domain/entities/location_entity.dart';
import 'package:edu_link/core/helpers/entities_handlers.dart';

class OfficeEntity {
  const OfficeEntity({this.location, this.availability, this.contactInfo});
  factory OfficeEntity.fromMap(Map<String, dynamic>? data) => OfficeEntity(
    location: complexEntity(data?['location'], LocationEntity.fromMap),
    availability: complexEntity(
      data?['availability'],
      AvailabilityEntity.fromMap,
    ),
    contactInfo: data?['contactInfo'],
  );

  final LocationEntity? location;
  final AvailabilityEntity? availability;
  final String? contactInfo;

  Map<String, dynamic> toMap() => {
    'location': location?.toMap(),
    'availability': availability?.toMap(),
    'contactInfo': contactInfo,
  };
}
