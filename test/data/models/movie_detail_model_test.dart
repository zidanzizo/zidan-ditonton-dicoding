import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
    genres: [],
    homepage: 'homepage',
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
  );

  final tMovieDetailJson = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'budget': 1,
    'id': 1,
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 1,
    'poster_path': 'posterPath',
    'release_date': 'releaseDate',
    'title': 'title',
    'video': false,
    'vote_average': 1,
    'vote_count': 1,
    'genres': [],
    'homepage': 'homepage',
    'imdb_id': 'imdbId',
    'original_language': 'originalLanguage',
    'revenue': 1,
    'runtime': 1,
    'status': 'status',
    'tagline': 'tagline',
  };

  test('should be a subclass of movie detail json', () async {
    final result = tMovieDetailModel.toJson();
    expect(result, tMovieDetailJson);
  });
}
