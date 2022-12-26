import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailResponse extends Equatable {
  final List<SeasonDetailModel> seasonDetailList;

  SeasonDetailResponse({required this.seasonDetailList});

  factory SeasonDetailResponse.fromJson(Map<String, dynamic> json) => SeasonDetailResponse(
        seasonDetailList:
            List<SeasonDetailModel>.from((json["episodes"] as List).map((x) => SeasonDetailModel.fromJson(x)).where((element) => element.stillPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "episodes": List<dynamic>.from(seasonDetailList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [seasonDetailList];
}
