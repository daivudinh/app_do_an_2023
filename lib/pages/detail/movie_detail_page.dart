import 'package:application/blocs/blocs.dart';
import 'package:application/pages/cast_and_crew/cast_and_crew_page.dart';
import 'package:application/pages/pages.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends StatelessWidget {
  static const String id = 'movie_detail';

  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    void openVideo(String? key) async {
      if (key == null) {
        debugPrint('Video key is null!');
      } else {
        final Uri _url = Uri.parse(youtubeUrl + key);
        if (await launchUrl(_url)) {
          await launchUrl(_url);
        }
      }
    }

    void gotoCastAndCrewPage(
        // type: 1 -> Movie
        // type: 2 -> TvSeries
        {required int? idMovie,
        required String? movieName,
        required int type}) {
      Navigator.of(context).pushNamed(CastAndCrewPage.id, arguments: {
        argsKeyMovieId: idMovie,
        argsKeyMovieName: movieName,
        argsKeyType: type
      });
    }

    return Scaffold(
      floatingActionButton: const GoBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case MovieDetailInitial:
                BlocProvider.of<MovieDetailBloc>(context).add(
                    // args: push argument with pushNamed (HomePage)
                    // argsKeyMovieId: argument key -> MovieId (const)
                    MovieDetailStartedEvent(idMovie: args[argsKeyMovieId]));
                break;
              case MovieDetailLoading:
                return const LoadingPlaceholder();
              case MovieDetailError:
                return Column(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Load detail movie fail :( !',
                          style: kTextSize30w400White,
                        ),
                      ),
                    ),
                  ],
                );
              case MovieDetailLoaded:
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          FadeInImage(
                            image: NetworkImage((state as MovieDetailLoaded)
                                        .movieDetail
                                        .backdropPath ==
                                    null
                                ? noPosterImage
                                : baseUrlImage +
                                    '${state.movieDetail.backdropPath}'),
                            placeholder: placeholderImage,
                            height: 300.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          state.videos.isNotEmpty
                              ? ButtonPlay(
                                  onTap: () => openVideo(state.videos[0].key))
                              : const SizedBox(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                      ),
                                      // color: Colors.yellow,
                                      child: Text(
                                        '${state.movieDetail.title}',
                                        style: kTextSize28w500White,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  const DisplayResolution4K(),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.timer,
                                    color: AppColor.white, size: 15.0),
                                const SizedBox(width: 8.0),
                                Text('${state.movieDetail.runtime} minutes',
                                    style: kTextSize15w400White),
                                const SizedBox(width: 20.0),
                                const Icon(Icons.star,
                                    color: AppColor.white, size: 15.0),
                                const SizedBox(width: 8.0),
                                Text('${state.movieDetail.popularity} (IMDb)',
                                    style: kTextSize15w400White)
                              ],
                            ),
                            const HorizontalDivider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Release date',
                                          style: kTextSize20w500White),
                                      const SizedBox(height: 15.0),
                                      Text('${state.movieDetail.releaseDate}',
                                          style: kTextSize15w400White),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Genre',
                                          style: kTextSize20w500White),
                                      const SizedBox(height: 10.0),

                                      // GenreItem(genre: 'Drama'),
                                      Wrap(
                                        children: state.movieDetail.genres!
                                            .map(
                                              (genre) => Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0, top: 10.0),
                                                child: GenreItem(
                                                    genre: genre.name ?? ""),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const HorizontalDivider(),
                            const Text('Overview', style: kTextSize20w400White),
                            const SizedBox(height: 15.0),
                            ReadMoreText(
                              '${state.movieDetail.overview}',
                              trimLines: 3,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: ' show less',
                              trimMode: TrimMode.Line,
                              style: kTextSize15w400White,
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              children: [
                                const Text('Cast & Crew',
                                    style: kTextSize20w500White),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => gotoCastAndCrewPage(
                                      idMovie: state.movieDetail.id,
                                      movieName: state.movieDetail.title,
                                      type: 1),
                                  child: const Text(
                                    'More...',
                                    style: kTextSize15w400White,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            CastAndCrewView(
                              crews: state.crews,
                              casts: state.casts,
                            ),
                            const SizedBox(height: 15.0),
                            const Text('Related Movie',
                                style: kTextSize20w500White),
                            const SizedBox(height: 20.0),
                            RelativeMovieView(
                              relativeMovies: state.similarList,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
