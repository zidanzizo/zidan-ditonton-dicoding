import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/series/get_ontheair_series.dart';
import 'package:flutter/foundation.dart';

class OntheAirSeriesNotifier extends ChangeNotifier {
  final GetOntheAirSeries getOntheAirSeries;

  OntheAirSeriesNotifier(this.getOntheAirSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchOntheAirSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOntheAirSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (seriesData) {
        _series = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
