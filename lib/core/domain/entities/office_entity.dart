import 'package:edu_link/core/domain/entities/availability_entity.dart';
import 'package:edu_link/core/domain/entities/location_entity.dart';

class OfficeEntity {
  const OfficeEntity({this.location, this.availability, this.contactInfo});
  factory OfficeEntity.fromMap(Map<String, dynamic>? data) => OfficeEntity(
    location: LocationEntity.fromMap(data?['location']),
    availability: AvailabilityEntity.fromMap(data?['availability']),
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
