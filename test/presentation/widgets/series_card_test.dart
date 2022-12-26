import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeries = Series(
    firstAirDate: '2022-02-01',
    name: 'name',
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'originalName',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  Widget createWidgetForTesting(SeriesCard child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Page should widget when data is ready', (WidgetTester tester) async {
    final inkWellFinder = find.byType(InkWell);
    final clipRRectFinder = find.byType(ClipRRect);

    await tester.pumpWidget(createWidgetForTesting(SeriesCard(tSeries)));

    expect(inkWellFinder, findsOneWidget);
    expect(clipRRectFinder, findsOneWidget);
  });
}
