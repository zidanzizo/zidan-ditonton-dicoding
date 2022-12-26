import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';

class GetSeriesSeasonDetail {
  final SeriesRepository repository;

  GetSeriesSeasonDetail(this.repository);

  Future<Either<Failure, List<SeasonDetail>>> execute(int tvId, int seasonNumber) {
    return repository.getSeriesSeasonDetail(tvId, seasonNumber);
  }
}
