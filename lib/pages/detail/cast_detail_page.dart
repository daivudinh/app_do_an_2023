import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class CastDetailPage extends StatelessWidget {
  static const String id = 'cast_detail';

  const CastDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Cast;
    return Scaffold(
      floatingActionButton: const GoBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: SizedBox(
                  height: 600.0,
                  width: double.infinity,
                  child: FadeInImage(
                    image: NetworkImage(args.profilePath == null
                        ? noProfileImage
                        : baseUrlImage + '${args.profilePath}'),
                    fit: BoxFit.cover,
                    placeholder: placeholderImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('${args.name}', style: kTextSize30w400White),
                    ),
                    const SizedBox(height: 10.0),
                    Text('Original name: ${args.originalName}',
                        style: kTextSize15w400White),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Gender: ${getGender(args.gender ?? 0)}',
                            style: kTextSize15w400White),
                        const SizedBox(height: 5.0),
                        Icon(getIconDataGender(args.gender ?? 0),
                            color: AppColor.white),
                        const SizedBox(width: 25.0),
                        Text('Popularity: ${args.popularity}',
                            style: kTextSize15w400White),
                        const SizedBox(width: 5.0),
                        const Icon(Icons.star, color: AppColor.white),
                      ],
                    ),
                    const HorizontalDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Role', style: kTextSize25w400White),
                              SizedBox(height: 10.0),
                              Text('Cast', style: kTextSize18w400White),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Known for',
                                  style: kTextSize25w400White),
                              const SizedBox(height: 10.0),
                              Text('${args.knownForDepartment}',
                                  style: kTextSize18w400White),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const HorizontalDivider(),
                    Text('Character: ${args.character}',
                        style: kTextSize25w400White),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
