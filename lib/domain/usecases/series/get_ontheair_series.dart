import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';

class GetOntheAirSeries {
  final SeriesRepository repository;

  GetOntheAirSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getOnTheAirSeries();
  }
}
