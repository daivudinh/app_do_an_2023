import 'package:application/pages/pages.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';

class CrewView extends StatelessWidget {
  const CrewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void gotoCrewDetail(Crew crew) {
      Navigator.of(context).pushNamed(CrewDetailPage.id, arguments: crew);
    }

    return BlocBuilder<CrewViewBloc, CrewViewState>(builder: (context, state) {
      if (state is CrewViewInitial) {
        return const LoadingPlaceholder();
      }
      return (state as CrewViewLoaded).crews.isNotEmpty
          ? StaggeredGridView.countBuilder(
              itemCount: state.crews.length,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) =>
                  const StaggeredTile.count(2, 3.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => gotoCrewDetail(state.crews[index]),
                    child: PersonCard(
                        avatar: state.crews[index].profilePath == null
                            ? noProfileImage
                            : baseUrlImage +
                                '${state.crews[index].profilePath}',
                        name: '${state.crews[index].name}'));
              },
            )
          : const Center(
              child: Text(
                'Nothing to show!',
                style: kTextSize20w400White,
              ),
            );
    });
  }
}
