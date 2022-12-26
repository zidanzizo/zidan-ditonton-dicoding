import 'package:ditonton/data/models/crew_model.dart';
import 'package:ditonton/domain/entities/crew.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tCrewModel = CrewModel(
      adult: false,
      character: 'character',
      creditId: 'creditId',
      department: 'department',
      gender: 1,
      id: 1,
      job: 'job',
      knownForDepartment: 'knownForDepartment',
      name: 'name',
      order: 'order',
      originalName: 'originalName',
      popularity: 0.0,
      profilePath: '/path.png');

  final tCrew = Crew(
      adult: false,
      character: 'character',
      creditId: 'creditId',
      department: 'department',
      gender: 1,
      id: 1,
      job: 'job',
      knownForDepartment: 'knownForDepartment',
      name: 'name',
      order: 'order',
      originalName: 'originalName',
      popularity: 0.0,
      profilePath: '/path.png');

  final tCrewJson = {
    "department": 'department',
    "job": 'job',
    "credit_id": 'creditId',
    "adult": false,
    "gender": 1,
    "id": 1,
    "known_for_department": 'knownForDepartment',
    "name": 'name',
    "original_name": 'originalName',
    "popularity": 0.0,
    "profile_path": '/path.png',
    "order": 'order',
    "character": 'character',
  };

  test('should be a subclass of crew entity', () async {
    final result = tCrewModel.toEntity();
    expect(result, tCrew);
  });

  test('should be a subclass of crew json', () async {
    final result = tCrewModel.toJson();
    expect(result, tCrewJson);
  });

  test('should be a subclass of crew from json', () async {
    final result = CrewModel.fromJson(tCrewJson);
    expect(result, tCrewModel);
  });
}
