import 'package:application/blocs/blocs.dart';
import 'package:application/pages/cast_and_crew/cast_and_crew_page.dart';
import 'package:application/pages/pages.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class TVSeriesDetailPage extends StatelessWidget {
  static const String id = 'tv_series_detail';

  const TVSeriesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    void openVideo(String? key) async {
      if (key == null) {
        debugPrint('Video key is null!');
      } else {
        final url = youtubeUrl + key;
        if (await canLaunch(url)) {
          await launch(url);
        }
      }
    }

    void gotoCastAndCrewPage(
        // type: 1 -> Movie
        // type: 2 -> TvSeries
        {required int? idTv,
        required String? tvSeriesName,
        required int type}) {
      Navigator.of(context).pushNamed(CastAndCrewPage.id, arguments: {
        argsKeyMovieId: idTv,
        argsKeyMovieName: tvSeriesName,
        argsKeyType: type
      });
    }

    return Scaffold(
      floatingActionButton: const GoBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: BlocBuilder<TVSeriesDetailBloc, TVSeriesDetailState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case TVSeriesDetailInitial:
                BlocProvider.of<TVSeriesDetailBloc>(context).add(
                    // args: push argument with pushNamed (DiscoverPage)
                    // argsKeyTvSeriesId: argument key -> TVSeriesId (const)
                    TVSeriesDetailStartedEvent(idTv: args[argsKeyTvSeriesId]));
                break;
              case TVSeriesDetailLoading:
                return const LoadingPlaceholder();
              case TVSeriesDetailError:
                return Column(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Load detail TV Series fail :( !',
                          style: kTextSize30w400White,
                        ),
                      ),
                    ),
                  ],
                );
              case TVSeriesDetailLoaded:
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          FadeInImage(
                            image: NetworkImage((state as TVSeriesDetailLoaded)
                                        .tvSeriesDetail
                                        .backdropPath ==
                                    null
                                ? noPosterImage
                                : baseUrlImage +
                                    '${state.tvSeriesDetail.backdropPath}'),
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
                              child: Center(
                                child: Text('${state.tvSeriesDetail.name}',
                                    style: kTextSize30w400White,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Number Of Seasons:\t${state.tvSeriesDetail.numberOfSeasons}',
                                        style: kTextSize18w400White),
                                    const SizedBox(height: 10.0),
                                    Text(
                                        'Number Of Episodes: \t${state.tvSeriesDetail.numberOfEpisodes}',
                                        style: kTextSize18w400White),
                                  ],
                                ),
                                const SizedBox(width: 20.0),
                                const Icon(Icons.star,
                                    color: AppColor.white, size: 15.0),
                                const SizedBox(width: 8.0),
                                Text(
                                    '${state.tvSeriesDetail.voteAverage} (IMDb)',
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
                                      const Text('First Air Date',
                                          style: kTextSize20w500White),
                                      const SizedBox(height: 10.0),
                                      Text(
                                          '${state.tvSeriesDetail.firstAirDate}',
                                          style: kTextSize15w400White),
                                      const SizedBox(height: 20.0),
                                      const Text('Last Air Date',
                                          style: kTextSize20w500White),
                                      const SizedBox(height: 10.0),
                                      Text(
                                          '${state.tvSeriesDetail.lastAirDate}',
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
                                        children: state.tvSeriesDetail.genres!
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
                              '${state.tvSeriesDetail.overview}',
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
                                      idTv: state.tvSeriesDetail.id,
                                      tvSeriesName: state.tvSeriesDetail.name,
                                      type: 2),
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
                            const Text('Related TV Show',
                                style: kTextSize20w500White),
                            const SizedBox(height: 20.0),
                            RelativeTVShowView(
                              relativeTvShows: state.similarList,
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
