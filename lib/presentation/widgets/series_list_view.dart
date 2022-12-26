import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/series_detail.dart';
import '../pages/series/series_season_detail_page.dart';

class SeriesListView extends StatelessWidget {
  const SeriesListView({
    Key? key,
    required this.series,
  }) : super(key: key);

  final SeriesDetail series;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final season = series.seasons[index];
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  key: Key('seasonInkWell'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      SeriesSeasonDetailPage.ROUTE_NAME,
                      arguments: {
                        "tvId": series.id,
                        "seasonNumber": season.seasonNumber,
                        "name": season.name,
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(season.name),
            ),
          ],
        );
      },
      itemCount: series.seasons.length,
    );
  }
}
