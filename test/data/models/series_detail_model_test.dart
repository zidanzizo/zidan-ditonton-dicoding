import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesDetailModel = SeriesDetailResponse(
    backdropPath: 'backdropPath',
    episodeRunTime: [],
    firstAirDate: 'firstAirDate',
    genres: [],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    languages: [],
    lastAirDate: 'lastAirDate',
    name: 'name',
    nextEpisodeToAir: 'nextEpisodeToAir',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: [],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    seasons: [],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tSeriesDetailJson = {
    'backdrop_path': 'backdropPath',
    'episode_run_time': [],
    'first_air_date': 'firstAirDate',
    'genres': [],
    'homepage': 'homepage',
    'id': 1,
    'in_production': false,
    'languages': [],
    'last_air_date': 'lastAirDate',
    'name': 'name',
    'next_episode_to_air': 'nextEpisodeToAir',
    'number_of_episodes': 1,
    'number_of_seasons': 1,
    'origin_country': [],
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'seasons': [],
    'status': 'status',
    'tagline': 'tagline',
    'type': 'type',
    'vote_average': 1.0,
    'vote_count': 1,
  };

  test('should be a subclass of series detail json', () async {
    final result = tSeriesDetailModel.toJson();
    expect(result, tSeriesDetailJson);
  });
}
