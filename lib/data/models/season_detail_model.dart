import 'package:ditonton/data/models/crew_model.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailModel extends Equatable {
  SeasonDetailModel({
    required this.airDate,
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String airDate;
  final int episodeNumber;
  final List<CrewModel> crew;
  final List<CrewModel> guestStars;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) => SeasonDetailModel(
        airDate: json["air_date"].toString(),
        episodeNumber: json["episode_number"],
        crew: List<CrewModel>.from(json["crew"].map((x) => CrewModel.fromJson(x))),
        guestStars: List<CrewModel>.from(json["guest_stars"].map((x) => CrewModel.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "guest_stars": List<dynamic>.from(guestStars.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  SeasonDetail toEntity() {
    return SeasonDetail(
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      crew: this.crew.map((crew) => crew.toEntity()).toList(),
      guestStars: this.crew.map((crew) => crew.toEntity()).toList(),
      id: this.id,
      name: this.name,
      overview: this.overview,
      productionCode: this.productionCode,
      seasonNumber: this.seasonNumber,
      stillPath: this.stillPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        crew,
        guestStars,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
