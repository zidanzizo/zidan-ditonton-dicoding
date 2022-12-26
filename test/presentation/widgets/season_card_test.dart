import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/presentation/widgets/season_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonDetail = SeasonDetail(
    airDate: 'airDate',
    crew: [],
    episodeNumber: 1,
    guestStars: [],
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  Widget createWidgetForTesting(SeasonCard child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Page should widget when data is ready', (WidgetTester tester) async {
    final cardFinder = find.byType(Card);
    final clipRRectFinder = find.byType(ClipRRect);

    await tester.pumpWidget(createWidgetForTesting(SeasonCard(tSeasonDetail)));

    expect(cardFinder, findsOneWidget);
    expect(clipRRectFinder, findsOneWidget);
  });
}
