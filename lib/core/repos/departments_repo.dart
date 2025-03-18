import 'dart:convert' show json;
import 'package:edu_link/core/domain/entities/department_entity.dart'
    show DepartmentEntity;
import 'package:flutter/services.dart' show rootBundle;

class DepartmentsRepo {
  Future<List<DepartmentEntity>> departments() => rootBundle
      .loadString('assets/database/departments.json')
      .then((value) => json.decode(value))
      .then(
        (value) =>
            List<Map<String, dynamic>>.from(
              value,
            ).map((e) => DepartmentEntity.fromMap(e)).toList(),
      );
}
