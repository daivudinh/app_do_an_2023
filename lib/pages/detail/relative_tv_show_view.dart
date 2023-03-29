import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';
import '../pages.dart';

class RelativeTVShowView extends StatelessWidget {
  const RelativeTVShowView({Key? key, required this.relativeTvShows})
      : super(key: key);

  final List<TVSeries> relativeTvShows;

  @override
  Widget build(BuildContext context) {

    void gotoDetail(int idTv){
      Navigator.of(context)
          .pushNamed(TVSeriesDetailPage.id, arguments: {argsKeyTvSeriesId: idTv});
    }

    return relativeTvShows.isNotEmpty
        ? SizedBox(
            height: 165.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: relativeTvShows.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => gotoDetail(relativeTvShows[index].id ?? 1),
                  child: RelatedCard(
                      poster: relativeTvShows[index].posterPath == null
                          ? noPosterImage
                          : baseUrlImage + '${relativeTvShows[index].posterPath}',
                      name: '${relativeTvShows[index].name}'),
                );
              },
            ),
          )
        : const Center(
            child: Text(
              'No movie available!',
              style: kTextSize20w400White,
            ),
          );
  }
}
