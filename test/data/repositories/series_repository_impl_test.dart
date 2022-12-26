import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/repositories/series_repository_impl.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesRepositoryImpl repository;
  late MockSeriesRemoteDataSource mockSeriesRemoteDataSource;
  late MockSeriesLocalDataSource mockSeriesLocalDataSource;

  setUp(() {
    mockSeriesRemoteDataSource = MockSeriesRemoteDataSource();
    mockSeriesLocalDataSource = MockSeriesLocalDataSource();
    repository = SeriesRepositoryImpl(
      remoteDataSource: mockSeriesRemoteDataSource,
      localDataSource: mockSeriesLocalDataSource,
    );
  });

  final tSeriesModel = Seriesmodel(
    firstAirDate: '2022-01-01',
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    name: 'name',
    originCountry: [],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tSeries = Series(
    firstAirDate: '2022-01-01',
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    name: 'name',
    originCountry: [],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    voteAverage: 7.2,
    voteCount: 13507,
  );

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

  final tSeasonDetail = SeasonDetail(
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

  final tSeriesModelList = <Seriesmodel>[tSeriesModel];
  final tSeriesList = <Series>[tSeries];
  final tSeasonDetailModelList = <SeasonDetailModel>[tSeasonDetailModel];
  final tSeasonDetailList = <SeasonDetail>[tSeasonDetail];

  group('On the Air Series', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getOnTheAirSeries()).thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getOnTheAirSeries();
      // assert
      verify(mockSeriesRemoteDataSource.getOnTheAirSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getOnTheAirSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirSeries();
      // assert
      verify(mockSeriesRemoteDataSource.getOnTheAirSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getOnTheAirSeries()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirSeries();
      // assert
      verify(mockSeriesRemoteDataSource.getOnTheAirSeries());
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Series', () {
    test('should return series list when call to data source is success', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getPopularSeries()).thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getPopularSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return server failure when call to data source is unsuccessful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getPopularSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return connection failure when device is not connected to the internet', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getPopularSeries()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularSeries();
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Series', () {
    test('should return series list when call to data source is successful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getTopRatedSeries()).thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getTopRatedSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getTopRatedSeries()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Series Detail', () {
    final tId = 1;
    final tSeriesResponse = SeriesDetailResponse(
      episodeRunTime: [1, 2],
      firstAirDate: '2022-01-01',
      inProduction: true,
      languages: ['en'],
      lastAirDate: '2022-12-12',
      name: 'name',
      nextEpisodeToAir: '2022-12-12',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['en'],
      originalName: 'originalName',
      seasons: [],
      type: 'type',
      backdropPath: 'backdropPath',
      genres: [],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 1,
      voteCount: 1,
    );

    test('should return series data when the call to remote data source is successful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId)).thenAnswer((_) async => tSeriesResponse);
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Right(testSeriesDetail)));
    });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Series Recommendations', () {
    final tSeriesList = <Seriesmodel>[];
    final tId = 1;

    test('should return data (series list) when the call is successful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesRecommendations(tId)).thenAnswer((_) async => tSeriesList);
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSeriesList));
    });

    test('should return server failure when call to remote data source is unsuccessful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesRecommendations(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockSeriesRemoteDataSource.getSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to the internet', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesRecommendations(tId)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesRecommendations(tId));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Series', () {
    final tQuery = 'game of thrones';

    test('should return series list when call to data source is successful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery)).thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockSeriesLocalDataSource.insertWatchlistSeries(testSeriesTable)).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockSeriesLocalDataSource.insertWatchlistSeries(testSeriesTable)).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockSeriesLocalDataSource.removeWatchlistSeries(testSeriesTable)).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockSeriesLocalDataSource.removeWatchlistSeries(testSeriesTable)).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockSeriesLocalDataSource.getSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist series', () {
    test('should return list of series', () async {
      // arrange
      when(mockSeriesLocalDataSource.getWatchlistSeries()).thenAnswer((_) async => [testSeriesTable]);
      // act
      final result = await repository.getWatchlistSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSeries]);
    });
  });

  group('Series season Detail', () {
    final tvId = 1;
    final seasonNumber = 1;
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getSeriesSeasonDetail(tvId, seasonNumber)).thenAnswer((_) async => tSeasonDetailModelList);
      // act
      final result = await repository.getSeriesSeasonDetail(tvId, seasonNumber);
      // assert
      verify(mockSeriesRemoteDataSource.getSeriesSeasonDetail(tvId, seasonNumber));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeasonDetailList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getOnTheAirSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirSeries();
      // assert
      verify(mockSeriesRemoteDataSource.getOnTheAirSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockSeriesRemoteDataSource.getOnTheAirSeries()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirSeries();
      // assert
      verify(mockSeriesRemoteDataSource.getOnTheAirSeries());
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
