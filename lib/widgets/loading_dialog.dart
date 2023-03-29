import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Row(
        children: [
          const SizedBox(width: 30),
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.all(40),
              child: Text(
                "Loading",
                style: kTextSize20w400White.copyWith(
                    color: Colors.black87),
              )),
        ],
      ),
    );
  }
}
