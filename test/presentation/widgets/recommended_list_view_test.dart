import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/widgets/recommended_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

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

  final tSeriesList = <Series>[tSeries];

  testWidgets('ListView.builder recommended ', (WidgetTester tester) async {
    final inkWellFinder = find.byType(InkWell);
    final clipRRectFinder = find.byType(ClipRRect);

    await tester.pumpWidget(createWidgetForTesting(RecommendedListView(recommendations: tSeriesList)));

    expect(inkWellFinder, findsOneWidget);
    expect(clipRRectFinder, findsOneWidget);
  });
}
