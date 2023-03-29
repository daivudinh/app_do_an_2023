import 'package:flutter/material.dart';
import '../../values/values.dart';

class SportView extends StatelessWidget {
   const SportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          child: Center(
            child: Text('Sport will be update soon!',style: kTextSize20w400White),
          ),
        ),
      ],
    );
  }


}
