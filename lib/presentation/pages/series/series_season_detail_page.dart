import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/series/series_season_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/season_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeriesSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/series-season-detail';

  final int tvId;
  final int seasonNumber;
  final String name;

  SeriesSeasonDetailPage({
    required this.tvId,
    required this.seasonNumber,
    required this.name,
  });

  @override
  _SeriesSeasonDetailPageState createState() => _SeriesSeasonDetailPageState();
}

class _SeriesSeasonDetailPageState extends State<SeriesSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<SeriesSeasonDetailNotifier>(context, listen: false).fetchSeriesSeasonDetail(widget.tvId, widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SeriesSeasonDetailNotifier>(
          builder: (context, data, child) {
            if (data.seasonDetailState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.seasonDetailState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final seasonDetail = data.seriesSeasonDetail[index];
                  return SeasonCard(seasonDetail);
                  // return Container(
                  //   height: 50,
                  //   width: 100,
                  //   color: Colors.red,
                  //   child: Text(seasonDetail.name),
                  // );
                },
                itemCount: data.seriesSeasonDetail.length,
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
