import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class CastAndCrewCard extends StatelessWidget {
  const CastAndCrewCard({
    Key? key,
    required this.avatar,
    required this.name,
  }) : super(key: key);

  final String avatar;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125.0,
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: FadeInImage(
              image: NetworkImage(avatar),
              fit: BoxFit.cover,
              placeholder: placeholderImage,
              height: 100.0,
              width: 125.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            name,
            style: kTextSize15w400White,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
