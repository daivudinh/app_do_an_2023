import 'dart:ui';

import 'package:application/values/values.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeMovieCard extends StatelessWidget {
  const HomeMovieCard({
    Key? key,
    required this.poster,
    required this.movieName,
    required this.voteAverage,
    required this.onGotoDetail,
  }) : super(key: key);

  final String poster;
  final String movieName;
  final String voteAverage;
  final Function()? onGotoDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGotoDetail,
      child: Stack(
        children: [
          Container(
            height: 400.0,
            width: 300.0,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(35.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35.0),
              child: CachedNetworkImage(
                imageUrl: poster,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 400.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    image: const DecorationImage(
                        image: placeholderImage, fit: BoxFit.cover),
                  ),
                ),
                // Image.asset('assets/images/placeholder.gif',fit: BoxFit.cover,),
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            bottom: 20.0,
            right: 20.0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  height: 90.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(width: 1.0, color: AppColor.black25),
                      color: AppColor.blur),
                  child: Center(
                      child: Text(
                    movieName,
                    style: kTextSize20w400White,
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20.0,
            right: 20.0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  height: 55.0,
                  width: 90.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(width: 1.0, color: AppColor.black25),
                      color: AppColor.blur),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('IMDb', style: kTextSize10w400White),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10.0),
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: AppColor.yellow,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            voteAverage,
                            style: kTextSize20w400White,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
