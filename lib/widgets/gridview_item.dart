import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    Key? key,
    required this.poster,
    required this.name,
  }) : super(key: key);

  final String poster;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(poster),
                fit: BoxFit.cover,
                placeholder: placeholderImage,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(minHeight: 60),
          padding: const EdgeInsets.only(bottom: 10, top: 5),
          child: Text(
            name,
            style: kTextSize15w400White,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
