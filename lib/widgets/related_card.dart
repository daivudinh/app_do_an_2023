import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class RelatedCard extends StatelessWidget {
  const RelatedCard({
    Key? key,
    required this.poster,
    required this.name,
  }) : super(key: key);

  final String poster;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
              placeholder: placeholderImage,
              height: 105.0,
              width: 140.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            name,
            style: kTextSize12w400White,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
