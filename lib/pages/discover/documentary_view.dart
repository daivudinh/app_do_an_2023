import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class DocumentaryView extends StatelessWidget {
  const DocumentaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          child: Center(
            child: Text('Documentary will be update soon!',
                style: kTextSize20w400White),
          ),
        ),
      ],
    );
  }
}
