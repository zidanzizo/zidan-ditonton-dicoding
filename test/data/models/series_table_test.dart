import 'package:ditonton/data/models/series_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesTable = SeriesTable(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: '/path.png',
  );

  final tSeriesTableJson = {
    "id": 1,
    "name": 'name',
    "overview": 'overview',
    "posterPath": '/path.png',
  };

  test('should be a subclass of series table json', () async {
    final result = tSeriesTable.toJson();
    expect(result, tSeriesTableJson);
  });
}
