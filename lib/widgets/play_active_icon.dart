import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class PlayActiveIcon extends StatelessWidget {
  const PlayActiveIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 35.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColor.iconColorStart,
                AppColor.iconColorEnd,
              ])),
      child: const Icon(
        Icons.play_arrow,
        color: AppColor.white,
      ),
    );
  }
}
