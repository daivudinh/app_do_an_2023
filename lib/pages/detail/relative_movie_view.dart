import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';
import '../pages.dart';

class RelativeMovieView extends StatelessWidget {
  const RelativeMovieView({Key? key, required this.relativeMovies})
      : super(key: key);

  final List<Movie> relativeMovies;

  @override
  Widget build(BuildContext context) {

    void gotoDetail(int idMovie){
      Navigator.of(context)
          .pushNamed(MovieDetailPage.id, arguments: {argsKeyMovieId: idMovie});
    }

    return relativeMovies.isNotEmpty
        ? SizedBox(
            height: 165.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: relativeMovies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => gotoDetail(relativeMovies[index].id ?? 1),
                  child: RelatedCard(
                      poster: relativeMovies[index].posterPath == null
                          ? noPosterImage
                          : baseUrlImage + '${relativeMovies[index].posterPath}',
                      name: '${relativeMovies[index].title}'),
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
