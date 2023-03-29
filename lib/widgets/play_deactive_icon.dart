import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class PlayDeActiveIcon extends StatelessWidget {
  const PlayDeActiveIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 35.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          color: AppColor.iconColorDeActive),
      child: const Icon(
        Icons.play_arrow,
        color: AppColor.white,
      ),
    );
  }
}
