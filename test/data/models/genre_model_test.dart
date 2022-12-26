import 'package:ditonton/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'name');

  final tGenreJson = {
    "id": 1,
    "name": 'name',
  };

  test('should be a subclass of genre json', () async {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });
}
