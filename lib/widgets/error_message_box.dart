import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class ErrorMessageBox extends StatelessWidget {
  const ErrorMessageBox({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.white25, width: 1.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20.0),
          const Icon(Icons.info_outline, size: 30.0, color: AppColor.red),
          const SizedBox(width: 20.0),
          Expanded(
              child: Text(
            message,
            style: kTextSize18w400Red,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          )),
          const SizedBox(width: 20.0),
        ],
      ),
    );
  }
}
