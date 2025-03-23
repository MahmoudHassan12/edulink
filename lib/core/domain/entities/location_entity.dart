class LocationEntity {
  const LocationEntity({this.building, this.floor, this.department, this.room});
  factory LocationEntity.fromMap(Map<String, dynamic>? data) => LocationEntity(
    building: data?['building'],
    floor: data?['floor'],
    department: data?['department'],
    room: data?['room'],
  );

  final String? building;
  final String? floor;
  final String? department;
  final String? room;

  Map<String, String?> toMap() => {
    'building': building,
    'floor': floor,
    'department': department,
    'room': room,
  };
}
