import 'package:application/blocs/blocs.dart';
import 'package:application/pages/cast_and_crew/cast_view.dart';
import 'package:application/pages/cast_and_crew/crew_view.dart';
import 'package:application/repositories/repositories.dart';
import 'package:application/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CastAndCrewPage extends StatelessWidget {
  static const String id = 'cast_and_crew_page';

  const CastAndCrewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      const Tab(text: 'Cast'),
      const Tab(text: 'Crew'),
    ];

    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.background,
          title: const Text('Cast & Crew', style: kTextSize28w500White),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 10.0),
            Text('Cast And Crew in: ${args[argsKeyMovieName]}'),
            TabBar(
              isScrollable: true,
              physics: const NeverScrollableScrollPhysics(),
              tabs: myTabs,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppColor.iconColorStart),
                  insets: EdgeInsets.only(right: 0)),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: AppColor.iconColorStart,
              unselectedLabelColor: AppColor.blur,
              labelStyle: kTextSize20w400White,
              onTap: (int index) {
                debugPrint(index.toString());
                BlocProvider.of<CastAndCrewBloc>(context)
                    .add(OnChangeTab(index));
              },
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: BlocBuilder<CastAndCrewBloc, CastAndCrewState>(
                builder: (context, state) {
                  return args[argsKeyType] == 1
                      ? IndexedStack(
                          index: (state as CastAndCrewInitial).index,
                          children: [
                            BlocProvider(
                              create: (context) =>
                                  CastViewBloc(CastAndCrewRepository())
                                    ..add(LoadCastInMovieEvent(
                                        idMovie: args[argsKeyMovieId])),
                              child: const CastView(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  CrewViewBloc(CastAndCrewRepository())
                                    ..add(LoadCrewInMovieEvent(
                                        idMovie: args[argsKeyMovieId])),
                              child: const CrewView(),
                            ),
                          ],
                        )
                      : IndexedStack(
                          index: (state as CastAndCrewInitial).index,
                          children: [
                            BlocProvider(
                              create: (context) =>
                                  CastViewBloc(CastAndCrewRepository())
                                    ..add(LoadCastInTVSeriesEvent(
                                        idTv: args[argsKeyMovieId])),
                              child: const CastView(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  CrewViewBloc(CastAndCrewRepository())
                                    ..add(LoadCrewInTVSeriesEvent(
                                        idTv: args[argsKeyMovieId])),
                              child: const CrewView(),
                            ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
