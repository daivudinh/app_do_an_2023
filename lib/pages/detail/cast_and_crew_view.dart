import 'package:application/models/models.dart';
import 'package:application/pages/pages.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';
import '../../widgets/widgets.dart';

class CastAndCrewView extends StatelessWidget {
  const CastAndCrewView({Key? key, required this.casts, required this.crews})
      : super(key: key);

  final List<Cast> casts;
  final List<Crew> crews;

  @override
  Widget build(BuildContext context) {
    void gotoCastDetail(Cast cast) {
      Navigator.of(context).pushNamed(CastDetailPage.id, arguments: cast);
    }

    void gotoCrewDetail(Crew crew) {
      Navigator.of(context).pushNamed(CrewDetailPage.id, arguments: crew);
    }

    return (casts.length + crews.length) != 0
        ? SizedBox(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (casts.length + crews.length) > 10
                  ? 10
                  : (casts.length + crews.length),
              itemBuilder: (context, index) {
                if (index >= casts.length) {
                  return GestureDetector(
                    onTap: () => gotoCrewDetail(crews[index - casts.length]),
                    child: CastAndCrewCard(
                        avatar: crews[index - casts.length].profilePath == null
                            ? noProfileImage
                            : baseUrlImage +
                                '${crews[index - casts.length].profilePath}',
                        name: '${crews[index - casts.length].name}'),
                  );
                }
                return casts.isNotEmpty
                    ? GestureDetector(
                        onTap: () => gotoCastDetail(casts[index]),
                        child: CastAndCrewCard(
                            avatar: casts[index].profilePath == null
                                ? noProfileImage
                                : baseUrlImage + '${casts[index].profilePath}',
                            name: '${casts[index].name}'),
                      )
                    : const SizedBox();
              },
            ),
          )
        : const Center(
            child: Text(
              'Nothing to show!',
              style: kTextSize20w400White,
            ),
          );
  }
}
