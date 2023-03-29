import 'package:flutter/material.dart';

import '../values/values.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No result found!\n$text will be updated soon!',
        style: kTextSize20w400White,
        textAlign: TextAlign.center,
      ),
    );
  }
}
