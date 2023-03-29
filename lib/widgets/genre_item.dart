import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  const GenreItem({Key? key, required this.genre}) : super(key: key);

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 8.0),
      decoration: BoxDecoration(
          color: AppColor.blur,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColor.white, width: 0.25),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.blur, AppColor.black25])),
      child: Text(genre, style: kTextSize15w400White),
    );
  }
}
