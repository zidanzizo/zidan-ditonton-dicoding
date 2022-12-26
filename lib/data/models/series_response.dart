import 'package:ditonton/data/models/series_model.dart';
import 'package:equatable/equatable.dart';

class SeriesResponse extends Equatable {
  final List<Seriesmodel> seriesList;

  SeriesResponse({required this.seriesList});

  factory SeriesResponse.fromJson(Map<String, dynamic> json) => SeriesResponse(
        seriesList: List<Seriesmodel>.from(
          (json["results"] as List).map((x) => Seriesmodel.fromJson(x)).where(
                (element) => element.posterPath != null,
              ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(seriesList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [seriesList];
}
