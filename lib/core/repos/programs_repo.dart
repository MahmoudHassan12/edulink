import 'dart:convert' show json;

import 'package:edu_link/core/domain/entities/program_entity.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProgramsRepo {
  Future<List<ProgramEntity>> programs() => rootBundle
      .loadString('assets/database/programs.json')
      .then((value) => json.decode(value))
      .then(
        (value) =>
            List<Map<String, dynamic>>.from(
              value,
            ).map((e) => ProgramEntity.fromMap(e)).toList(),
      );
}
