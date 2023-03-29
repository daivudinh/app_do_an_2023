import 'package:application/values/values.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({Key? key, required this.avatar, required this.name})
      : super(key: key);

  final String avatar;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: 185.0,
      child: Column(
        children: [
          SizedBox(
            width: 185.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: FadeInImage(
                placeholder: placeholderImage,
                image: NetworkImage(avatar),
                height: 220.0,
                width: 185.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            name,
            style: kTextSize20w400White,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
