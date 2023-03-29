import 'package:application/blocs/blocs.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/models.dart';
import '../pages.dart';

class CastView extends StatelessWidget {
  const CastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void gotoCastDetail(Cast cast) {
      Navigator.of(context).pushNamed(CastDetailPage.id, arguments: cast);
    }

    return BlocBuilder<CastViewBloc, CastViewState>(
      builder: (context, state) {
        if (state is CastViewInitial) {
          return const LoadingPlaceholder();
        }
        return (state as CastViewLoaded).casts.isNotEmpty
            ? StaggeredGridView.countBuilder(
                itemCount: state.casts.length,
                crossAxisCount: 4,
                staggeredTileBuilder: (index) =>
                    const StaggeredTile.count(2, 3.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => gotoCastDetail(state.casts[index]),
                      child: PersonCard(
                        avatar: state.casts[index].profilePath == null
                            ? noProfileImage
                            : baseUrlImage +
                                '${state.casts[index].profilePath}',
                        name: '${state.casts[index].name}',
                      ));
                },
              )
            : const Center(
                child: Text(
                  'Nothing to show!',
                  style: kTextSize20w400White,
                ),
              );
      },
    );
  }
}
