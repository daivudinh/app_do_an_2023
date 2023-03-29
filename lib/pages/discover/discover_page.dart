import 'package:application/pages/pages.dart';
import 'package:application/repositories/repositories.dart';
import 'package:application/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../blocs/blocs.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DiscoverBloc discoverBloc = BlocProvider.of<DiscoverBloc>(context);

    List<Tab> discoverTabs = const <Tab>[
      Tab(text: 'Movies'),
      Tab(text: 'Tv Series'),
      Tab(text: 'Documentary'),
      Tab(text: 'Sports'),
    ];

    _onSearchMovie(String query) {
      discoverBloc.add(OnSearch(query: query));
    }

    void _onClearSearch() {
      discoverBloc.add(OnClear());
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              Wrap(
                children: const [
                  Text('Find Movies, Tv series, and more..',
                      style: kTextSize30w400White),
                ],
              ),
              const SizedBox(height: 20.0),
              BlocBuilder<DiscoverBloc, DiscoverState>(
                builder: (context, state) {
                  return TextField(
                    controller: discoverBloc.search,
                    onChanged: _onSearchMovie,
                    decoration: InputDecoration(
                      hintText: 'Sherlock Holmes',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Icon(Icons.search,
                            color: AppColor.white, size: 30.0),
                      ),
                      suffixIcon: discoverBloc.search.text.isEmpty
                          ? null
                          : GestureDetector(
                              onTap: () => _onClearSearch(),
                              child: const Icon(Icons.clear,
                                  size: 30.0, color: AppColor.white),
                            ),
                      filled: true,
                      fillColor: AppColor.searchTextField,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              DefaultTabController(
                length: discoverTabs.length,
                child: TabBar(
                  tabs: discoverTabs,
                  physics: const NeverScrollableScrollPhysics(),
                  labelColor: AppColor.iconColorStart,
                  unselectedLabelColor: AppColor.white,
                  indicatorColor: AppColor.iconColorStart,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  labelStyle: kTextSize15w400White,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(color: AppColor.iconColorStart),
                    insets: EdgeInsets.only(right: 30.0),
                  ),
                  onTap: (int index) {
                    BlocProvider.of<DiscoverBloc>(context)
                        .add(OnChangeTabDiscover(index: index));
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              BlocBuilder<DiscoverBloc, DiscoverState>(
                builder: (context, state) {
                  return Expanded(
                    child: IndexedStack(
                      index: (state as InitDiscover).index,
                      children: [
                        BlocProvider(
                          create: (context) => DiscoverMovieViewBloc(
                              DiscoverRepository(),
                              discoverBloc,
                              RefreshController())
                            ..add(MovieFetchingEvent()),
                          child: const MovieView(),
                        ),
                        BlocProvider(
                          create: (context) => DiscoverTVSeriesViewBloc(
                              DiscoverRepository(),
                              discoverBloc,
                              RefreshController())
                            ..add(TVSeriesFetchingEvent()),
                          child: const TVSeriesView(),
                        ),
                        const DocumentaryView(),
                        const SportView(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
