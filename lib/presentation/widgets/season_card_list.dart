import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:flutter/material.dart';

class SeasonCard extends StatelessWidget {
  final SeasonDetail seasonDetail;

  SeasonCard(this.seasonDetail);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.brown[900],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: '$BASE_IMAGE_URL${seasonDetail.stillPath}',
                      width: screenWidth,
                      // height: 80,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  Container(
                    width: 90,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.black.withOpacity(0.65),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Episode ${seasonDetail.episodeNumber}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  seasonDetail.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kHeading6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  seasonDetail.overview.isEmpty ? 'No overview\n ' : seasonDetail.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
