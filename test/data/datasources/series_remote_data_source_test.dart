import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/data/models/season_detail_response.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On the Air Series', () {
    final tSeriesList = SeriesResponse.fromJson(json.decode(readJson('dummy_data/on_the_air.json'))).seriesList;

    test('should return list of Series Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/on_the_air.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getOnTheAirSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Series', () {
    final tSeriesList = SeriesResponse.fromJson(json.decode(readJson('dummy_data/popular_series.json'))).seriesList;

    test('should return list of series when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer(
        (_) async => http.Response(readJson('dummy_data/popular_series.json'), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }),
      );
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, tSeriesList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Series', () {
    final tSeriesList = SeriesResponse.fromJson(json.decode(readJson('dummy_data/top_rated_series.json'))).seriesList;

    test('should return list of series when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/top_rated_series.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, tSeriesList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series detail', () {
    final tId = 1;
    final tSeriesDetail = SeriesDetailResponse.fromJson(json.decode(readJson('dummy_data/series_detail.json')));

    test('should return series detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/series_detail.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getSeriesDetail(tId);
      // assert
      expect(result, equals(tSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series recommendations', () {
    final tSeriesList = SeriesResponse.fromJson(json.decode(readJson('dummy_data/series_recommendations.json'))).seriesList;
    final tId = 1;

    test('should return list of series Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/series_recommendations.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getSeriesRecommendations(tId);
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search series', () {
    final tSearchResult = SeriesResponse.fromJson(json.decode(readJson('dummy_data/search_game_of_thrones_series.json'))).seriesList;
    final tQuery = 'Game of thrones';

    test('should return list of series when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/search_game_of_thrones_series.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.searchSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Series Season Detail', () {
    final tSeasonDetailList = SeasonDetailResponse.fromJson(json.decode(readJson('dummy_data/series_season_detail.json'))).seasonDetailList;
    final tTvId = 1;
    final tSeasonNumber = 1;

    test('should return list of Series season detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tTvId/season/$tSeasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/series_season_detail.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getSeriesSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(result, equals(tSeasonDetailList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tTvId/season/$tSeasonNumber?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
