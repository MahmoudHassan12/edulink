import 'package:edu_link/core/domain/entities/availability_entity.dart';
import 'package:edu_link/core/domain/entities/available_time_entity.dart'
    show AvailableTimeEntity;
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

  OfficeEntity copyWith({
    LocationEntity? location,
    AvailabilityEntity? availability,
    String? contactInfo,
  }) => OfficeEntity(
    location: location ?? this.location,
    availability: availability ?? this.availability,
    contactInfo: contactInfo ?? this.contactInfo,
  );

  Map<String, dynamic> toMap() => {
    'location': location?.toMap(),
    'availability': availability?.toMap(),
    'contactInfo': contactInfo,
  };
  OfficeEntity setBuilding(String building) =>
      copyWith(location: location?.setBuilding(building));
  OfficeEntity setFloor(String floor) =>
      copyWith(location: location?.setFloor(floor));
  OfficeEntity setDepartment(String? department) =>
      copyWith(location: location?.setDepartment(department));
  OfficeEntity setRoom(String room) =>
      copyWith(location: location?.setRoom(room));
  OfficeEntity setAvailableTime(
    AvailableTimeEntity availableTime, [
    int? index,
  ]) => copyWith(
    availability: availability?.setAvailableTime(availableTime, index),
  );
  OfficeEntity setContactInfo(String contactInfo) =>
      copyWith(contactInfo: contactInfo);
}
