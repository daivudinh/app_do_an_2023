import 'package:application/blocs/blocs.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../pages.dart';

class MovieView extends StatelessWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void gotoMovieDetail(int movieId) {
      Navigator.of(context)
          .pushNamed(MovieDetailPage.id, arguments: {argsKeyMovieId: movieId});
    }

    DiscoverMovieViewBloc movieViewBloc =
        BlocProvider.of<DiscoverMovieViewBloc>(context);

    void _onLoading() {
      movieViewBloc.add(OnNextMovieEvent());
    }

    return BlocBuilder<DiscoverMovieViewBloc, DiscoverMovieViewState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case DiscoverMovieListEmpty:
            return EmptyList(text: (state as DiscoverMovieListEmpty).text);
          case DiscoverMovieLoadFailure:
            return const Center(
              child: Text(
                'Error load movie',
                style: kTextSize20w400White,
              ),
            );
          case DiscoverMovieListLoaded:
            return SmartRefresher(
              enablePullDown: false,
              enablePullUp:
                  (state as DiscoverMovieListLoaded).currentPage != -1,
              controller: movieViewBloc.movieController,
              onLoading: _onLoading,
              child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.only(top: 10.0),
                crossAxisCount: 4,
                itemCount: state.lists.length,
                mainAxisSpacing: 10,
                crossAxisSpacing: 22,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => gotoMovieDetail(state.lists[index].id ?? 1),
                    child: GridViewItem(
                      poster: state.lists[index].posterPath == null
                          ? noPosterImage
                          : baseUrlImage + '${state.lists[index].posterPath}',
                      name: '${state.lists[index].title}',
                    ),
                  );
                },
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index % 2 == 0 ? 3.7 : 2.7),
              ),
            );
        }
        return const LoadingPlaceholder();
      },
    );
  }
}
