import 'package:ditonton/presentation/widgets/series_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('ListView.builder series ', (WidgetTester tester) async {
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(createWidgetForTesting(SeriesListView(series: testSeriesDetail)));

    expect(listViewFinder, findsOneWidget);
  });
}
