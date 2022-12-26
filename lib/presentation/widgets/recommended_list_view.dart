import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/series.dart';
import '../pages/series/series_detail_page.dart';

class RecommendedListView extends StatelessWidget {
  const RecommendedListView({
    Key? key,
    required this.recommendations,
  }) : super(key: key);

  final List<Series> recommendations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final series = recommendations[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            key: Key('recInkWell'),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                SeriesDetailPage.ROUTE_NAME,
                arguments: series.id,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        );
      },
      itemCount: recommendations.length,
    );
  }
}
