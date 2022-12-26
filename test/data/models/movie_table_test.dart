import 'package:ditonton/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: '/path.png',
  );

  final tMovieTableJson = {
    "id": 1,
    "title": 'title',
    "overview": 'overview',
    "posterPath": '/path.png',
  };

  test('should be a subclass of movie table json', () async {
    final result = tMovieTable.toJson();
    expect(result, tMovieTableJson);
  });
}
