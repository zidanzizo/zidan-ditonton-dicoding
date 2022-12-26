import 'package:ditonton/data/models/crew_model.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/domain/entities/crew.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonDetailModel = SeasonDetailModel(
    airDate: '2022-01-01',
    crew: [
      CrewModel(
        department: 'department',
        job: 'job',
        creditId: 'creditId',
        adult: false,
        gender: 1,
        id: 1,
        knownForDepartment: 'knownForDepartment',
        name: 'name',
        originalName: 'originalName',
        popularity: 1.0,
        profilePath: 'profilePath',
        order: 'order',
        character: 'character',
      ),
    ],
    episodeNumber: 1,
    guestStars: [
      CrewModel(
        department: 'department',
        job: 'job',
        creditId: 'creditId',
        adult: false,
        gender: 1,
        id: 1,
        knownForDepartment: 'knownForDepartment',
        name: 'name',
        originalName: 'originalName',
        popularity: 1.0,
        profilePath: 'profilePath',
        order: 'order',
        character: 'character',
      ),
    ],
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tSeasonDetail = SeasonDetail(
    airDate: '2022-01-01',
    crew: [
      Crew(
        department: 'department',
        job: 'job',
        creditId: 'creditId',
        adult: false,
        gender: 1,
        id: 1,
        knownForDepartment: 'knownForDepartment',
        name: 'name',
        originalName: 'originalName',
        popularity: 1.0,
        profilePath: 'profilePath',
        order: 'order',
        character: 'character',
      ),
    ],
    episodeNumber: 1,
    guestStars: [
      Crew(
        department: 'department',
        job: 'job',
        creditId: 'creditId',
        adult: false,
        gender: 1,
        id: 1,
        knownForDepartment: 'knownForDepartment',
        name: 'name',
        originalName: 'originalName',
        popularity: 1.0,
        profilePath: 'profilePath',
        order: 'order',
        character: 'character',
      ),
    ],
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of season detail entity', () async {
    final result = tSeasonDetailModel.toEntity();
    expect(result, tSeasonDetail);
  });
}
