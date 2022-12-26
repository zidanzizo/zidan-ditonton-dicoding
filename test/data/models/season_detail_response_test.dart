import 'dart:convert';

import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/data/models/season_detail_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeasonDetailModel = SeasonDetailModel(
    airDate: '2022-01-01',
    crew: [],
    episodeNumber: 1,
    guestStars: [],
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tSeasonDetailResponseModel = SeasonDetailResponse(seasonDetailList: <SeasonDetailModel>[tSeasonDetailModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/series_season_detail.json'));
      // act
      final result = SeasonDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeasonDetailResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeasonDetailResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            "air_date": "2022-01-01",
            "crew": [],
            "episode_number": 1,
            "guest_stars": [],
            "id": 1,
            "name": "name",
            "overview": "overview",
            "production_code": "productionCode",
            "season_number": 1,
            "still_path": "stillPath",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
