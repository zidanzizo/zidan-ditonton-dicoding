import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/series/search_series.dart';
import 'package:ditonton/presentation/provider/series/series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SeriesSearchNotifier provider;
  late MockSearchSeries mockSearchSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchSeries = MockSearchSeries();
    provider = SeriesSearchNotifier(searchSeries: mockSearchSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

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
  final tSeriesList = <Series>[tSeries];
  final tQuery = 'game of thrones';

  group('search series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery)).thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery)).thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
