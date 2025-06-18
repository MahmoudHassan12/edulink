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

  LocationEntity copyWith({
    String? building,
    String? floor,
    String? department,
    String? room,
  }) => LocationEntity(
    building: building ?? this.building,
    floor: floor ?? this.floor,
    department: department ?? this.department,
    room: room ?? this.room,
  );

  Map<String, String?> toMap() => {
    'building': building,
    'floor': floor,
    'department': department,
    'room': room,
  };

  LocationEntity setBuilding(String building) => copyWith(building: building);
  LocationEntity setFloor(String floor) => copyWith(floor: floor);
  LocationEntity setDepartment(String? department) =>
      copyWith(department: department);
  LocationEntity setRoom(String room) => copyWith(room: room);
  bool isValid() => building != null &&
        floor != null &&
        department != null &&
        room != null;
}
