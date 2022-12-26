import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/data/models/season_detail_response.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:http/http.dart' as http;

abstract class SeriesRemoteDataSource {
  Future<List<Seriesmodel>> getOnTheAirSeries();
  Future<List<Seriesmodel>> getPopularSeries();
  Future<List<Seriesmodel>> getTopRatedSeries();
  Future<SeriesDetailResponse> getSeriesDetail(int id);
  Future<List<Seriesmodel>> getSeriesRecommendations(int id);
  Future<List<Seriesmodel>> searchSeries(String query);
  Future<List<SeasonDetailModel>> getSeriesSeasonDetail(int tvId, int seasonNumber);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  SeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Seriesmodel>> getOnTheAirSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeriesDetailResponse> getSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Seriesmodel>> getSeriesRecommendations(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Seriesmodel>> getPopularSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Seriesmodel>> getTopRatedSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Seriesmodel>> searchSeries(String query) async {
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeasonDetailModel>> getSeriesSeasonDetail(int tvId, int seasonNumber) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$tvId/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonDetailResponse.fromJson(json.decode(response.body)).seasonDetailList;
    } else {
      throw ServerException();
    }
  }
}
