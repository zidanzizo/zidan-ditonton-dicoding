import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
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
  );

  Widget createWidgetForTesting(MovieCard child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Page should widget when data is ready', (WidgetTester tester) async {
    final inkWellFinder = find.byType(InkWell);
    final clipRRectFinder = find.byType(ClipRRect);

    await tester.pumpWidget(createWidgetForTesting(MovieCard(tMovie)));

    expect(inkWellFinder, findsOneWidget);
    expect(clipRRectFinder, findsOneWidget);
  });
}
