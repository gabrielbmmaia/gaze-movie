import 'package:flutter/material.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailersItem extends StatelessWidget {
  const TrailersItem({required this.trailer, super.key});

  final YoutubeTrailersModel trailer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 170,
      width: 240,
      child: InkWell(
        onTap: () async {
          final youtubeUrl = Uri.parse(
            'https://www.youtube.com/embed/${trailer.trailerKey}',
          );
          if (await canLaunchUrl(youtubeUrl)) {
            await launchUrl(youtubeUrl);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 134,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img.youtube.com/vi/${trailer.trailerKey}/0.jpg',
                  ),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
              child: Text(
                trailer.trailerTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
