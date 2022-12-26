import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/usecases/series/get_series_season_detail.dart';
import 'package:flutter/foundation.dart';

class SeriesSeasonDetailNotifier extends ChangeNotifier {
  var _seriesSeasonDetail = <SeasonDetail>[];
  List<SeasonDetail> get seriesSeasonDetail => _seriesSeasonDetail;

  var _seasonDetailState = RequestState.Empty;
  RequestState get seasonDetailState => _seasonDetailState;

  String _message = '';
  String get message => _message;

  SeriesSeasonDetailNotifier({required this.getSeriesSeasonDetail});

  final GetSeriesSeasonDetail getSeriesSeasonDetail;

  Future<void> fetchSeriesSeasonDetail(int tvId, int seasonNumber) async {
    _seasonDetailState = RequestState.Loading;
    notifyListeners();

    final result = await getSeriesSeasonDetail.execute(tvId, seasonNumber);
    result.fold(
      (failure) {
        _seasonDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seasonDetailData) {
        _seasonDetailState = RequestState.Loaded;
        _seriesSeasonDetail = seasonDetailData;
        notifyListeners();
      },
    );
  }
}
