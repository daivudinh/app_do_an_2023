import 'dart:ui';

import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class ButtonPlay extends StatelessWidget {
  const ButtonPlay({Key? key, required this.onTap}) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 2.5, sigmaX: 2.5),
          child: Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.white, width: 0.2),
              shape: BoxShape.circle,
              color: AppColor.black,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor.white25,
                    AppColor.black25,
                  ]),
            ),
            child: const Icon(Icons.play_arrow,
                color: AppColor.iconColorStart, size: 40.0),
          ),
        ),
      ),
    );
  }
}
