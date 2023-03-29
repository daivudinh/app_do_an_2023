import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    this.hasTwoButton = true,
    required this.title,
    required this.content,
    required this.onSubmit,
  }) : super(key: key);

  final bool hasTwoButton;
  final String title;
  final String content;
  final Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 200,
        width: 400,
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30.0),
              Text(
                title,
                style: kTextSize20w400White.copyWith(
                    fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: Text(
                  content,
                  style: kTextSize15w400White.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 20.0),
                  hasTwoButton
                      ? GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text('Back',
                              style: kTextSize20w400Blue.copyWith(
                                  fontStyle: FontStyle.italic)))
                      : const SizedBox(),
                  const Spacer(),
                  GestureDetector(
                      onTap: onSubmit,
                      child: Text('OK',
                          style: kTextSize20w400Red.copyWith(
                              fontStyle: FontStyle.italic))),
                  const SizedBox(width: 20.0),
                ],
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
