import 'package:ditonton/domain/entities/crew.dart';
import 'package:equatable/equatable.dart';

class CrewModel extends Equatable {
  CrewModel({
    required this.department,
    required this.job,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.order,
    required this.character,
  });

  final String department;
  final String job;
  final String creditId;
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final String order;
  final String character;

  factory CrewModel.fromJson(Map<String, dynamic> json) => CrewModel(
        department: json["department"].toString(),
        job: json["job"].toString(),
        creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"].toString(),
        order: json["order"].toString(),
        character: json["character"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "department": department,
        "job": job,
        "credit_id": creditId,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "order": order,
        "character": character,
      };

  Crew toEntity() {
    return Crew(
      department: this.department,
      job: this.job,
      creditId: this.creditId,
      adult: this.adult,
      gender: this.gender,
      id: this.id,
      knownForDepartment: this.knownForDepartment,
      name: this.name,
      originalName: this.originalName,
      popularity: this.popularity,
      profilePath: this.profilePath,
      order: this.order,
      character: this.character,
    );
  }

  @override
  List<Object?> get props => [
        department,
        job,
        creditId,
        adult,
        gender,
        id,
        knownForDepartment,
        name,
        originalName,
        popularity,
        profilePath,
        order,
        character,
      ];
}
