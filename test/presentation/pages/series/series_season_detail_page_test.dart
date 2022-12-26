import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/presentation/pages/series/series_season_detail_page.dart';
import 'package:ditonton/presentation/provider/series/series_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'series_season_detail_page_test.mocks.dart';

@GenerateMocks([SeriesSeasonDetailNotifier])
void main() {
  late MockSeriesSeasonDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSeriesSeasonDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SeriesSeasonDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tvId = 1;
  final seasonNumber = 1;
  final name = 'name';

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.seasonDetailState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(SeriesSeasonDetailPage(
      tvId: tvId,
      seasonNumber: seasonNumber,
      name: name,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
    when(mockNotifier.seasonDetailState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seriesSeasonDetail).thenReturn(<SeasonDetail>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SeriesSeasonDetailPage(
      tvId: tvId,
      seasonNumber: seasonNumber,
      name: name,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
    when(mockNotifier.seasonDetailState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SeriesSeasonDetailPage(
      tvId: tvId,
      seasonNumber: seasonNumber,
      name: name,
    )));

    expect(textFinder, findsOneWidget);
  });
}
