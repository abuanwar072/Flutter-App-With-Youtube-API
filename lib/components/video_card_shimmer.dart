import 'package:flutter/material.dart';

import '../constants.dart';
import 'shimmer.dart';

class VideoCardShimmer extends StatelessWidget {
  const VideoCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        AspectRatio(
          aspectRatio: 1.75,
          child: Shimmer(),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
            height: 20,
            child: Shimmer(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SizedBox(
            height: 20,
            child: Shimmer(),
          ),
        ),
      ],
    );
  }
}
