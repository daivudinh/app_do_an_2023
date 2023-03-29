import 'package:flutter/material.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(
                    'assets/images/image_placeholder.gif')),
          ),
        ),
      ],
    );
  }
}
