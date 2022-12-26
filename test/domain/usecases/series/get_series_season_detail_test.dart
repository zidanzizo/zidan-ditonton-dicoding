import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/usecases/series/get_series_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesSeasonDetail usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesSeasonDetail(mockSeriesRepository);
  });

  final tSeasonDetail = <SeasonDetail>[];
  final tvId = 1;
  final seasonNumber = 1;

  group('get series season detail Tests', () {
    group('execute', () {
      test('should get list of series season detail from the repository when execute function is called', () async {
        // arrange
        when(mockSeriesRepository.getSeriesSeasonDetail(tvId, seasonNumber)).thenAnswer((_) async => Right(tSeasonDetail));
        // act
        final result = await usecase.execute(tvId, seasonNumber);
        // assert
        expect(result, Right(tSeasonDetail));
      });
    });
  });
}
