import 'package:application/pages/pages.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../blocs/blocs.dart';

class TVSeriesView extends StatelessWidget {
  const TVSeriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DiscoverTVSeriesViewBloc tvSeriesViewBloc =
        BlocProvider.of<DiscoverTVSeriesViewBloc>(context);

    void gotoTVSeriesDetail(int tvId) {
      Navigator.of(context).pushNamed(TVSeriesDetailPage.id,
          arguments: {argsKeyTvSeriesId: tvId});
    }

    void _onLoading() {
      tvSeriesViewBloc.add(OnNextTVSeriesEvent());
    }

    return BlocBuilder<DiscoverTVSeriesViewBloc, DiscoverTVSeriesViewState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case DiscoverTVSeriesListEmpty:
            return EmptyList(text: (state as DiscoverTVSeriesListEmpty).text);
          case DiscoverTVSeriesLoadFailure:
            return const Center(
              child: Text(
                'Error load TV Series',
                style: kTextSize20w400White,
              ),
            );
          case DiscoverTVSeriesListLoaded:
            return SmartRefresher(
              enablePullDown: false,
              enablePullUp:
                  (state as DiscoverTVSeriesListLoaded).currentPage != -1,
              controller: tvSeriesViewBloc.tvSeriesController,
              onLoading: _onLoading,
              child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.only(top: 10.0),
                crossAxisCount: 4,
                itemCount: state.lists.length,
                mainAxisSpacing: 10,
                crossAxisSpacing: 22,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => gotoTVSeriesDetail(state.lists[index].id ?? 1),
                    child: GridViewItem(
                      poster: state.lists[index].posterPath == null
                          ? noPosterImage
                          : baseUrlImage + '${state.lists[index].posterPath}',
                      name: '${state.lists[index].name}',
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
