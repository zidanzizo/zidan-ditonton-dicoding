import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/usecases/series/get_series_season_detail.dart';
import 'package:ditonton/presentation/provider/series/series_season_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_season_detail_notifier_test.mocks.dart';

@GenerateMocks([GetSeriesSeasonDetail])
void main() {
  late MockGetSeriesSeasonDetail mockGetSeriesSeasonDetail;
  late SeriesSeasonDetailNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesSeasonDetail = MockGetSeriesSeasonDetail();
    notifier = SeriesSeasonDetailNotifier(getSeriesSeasonDetail: mockGetSeriesSeasonDetail)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tSeasonDetail = SeasonDetail(
    airDate: 'airDate',
    crew: [],
    episodeNumber: 1,
    guestStars: [],
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );
  final tSeasonDetailList = <SeasonDetail>[tSeasonDetail];
  final tvId = 1;
  final seasonNumber = 1;

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetSeriesSeasonDetail.execute(tvId, seasonNumber)).thenAnswer((_) async => Right(tSeasonDetailList));
    // act
    notifier.fetchSeriesSeasonDetail(tvId, seasonNumber);
    // assert
    expect(notifier.seasonDetailState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change series season detail data when data is gotten successfully', () async {
    // arrange
    when(mockGetSeriesSeasonDetail.execute(tvId, seasonNumber)).thenAnswer((_) async => Right(tSeasonDetailList));
    // act
    await notifier.fetchSeriesSeasonDetail(tvId, seasonNumber);
    // assert
    expect(notifier.seasonDetailState, RequestState.Loaded);
    expect(notifier.seriesSeasonDetail, tSeasonDetailList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetSeriesSeasonDetail.execute(tvId, seasonNumber)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchSeriesSeasonDetail(tvId, seasonNumber);
    // assert
    expect(notifier.seasonDetailState, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
