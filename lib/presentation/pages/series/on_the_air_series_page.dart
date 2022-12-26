import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/series/on_the_air_series_notifier.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OntheAirSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/ontheair-series';

  @override
  _OntheAirSeriesPageState createState() => _OntheAirSeriesPageState();
}

class _OntheAirSeriesPageState extends State<OntheAirSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<OntheAirSeriesNotifier>(context, listen: false).fetchOntheAirSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OntheAirSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final selectedSeries = data.series[index];
                  return SeriesCard(selectedSeries);
                },
                itemCount: data.series.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
