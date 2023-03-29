import 'dart:ui';

import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OfficialTrailerCard extends StatelessWidget {
  const OfficialTrailerCard({
    Key? key,
    required this.image,
    required this.onGotoDetail,
    required this.onPlayMovie,
  }) : super(key: key);

  final String image;
  final Function()? onGotoDetail;
  final Function()? onPlayMovie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onGotoDetail,
          child: Container(
            height: 230.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 28.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: FadeInImage(
                  placeholder: placeholderImage,
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        Positioned(
          left: 45.0,
          bottom: 10.0,
          child: GestureDetector(
            onTap: onPlayMovie,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  height: 75.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    color: AppColor.blur,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    children: const [
                      SizedBox(width: 25.0),
                      PlayActiveIcon(),
                      SizedBox(width: 25.0),
                      Text('Official Trailer', style: kTextSize20w400White),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
