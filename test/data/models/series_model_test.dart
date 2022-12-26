import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesModel = Seriesmodel(
    firstAirDate: '2022-02-01',
    name: 'name',
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'originalName',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeries = Series(
    firstAirDate: '2022-02-01',
    name: 'name',
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'originalName',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of series entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
