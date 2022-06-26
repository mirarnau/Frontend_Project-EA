import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';

class LoadingCards extends StatelessWidget {
  const LoadingCards({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);
  
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<double> ( //
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      tween: Tween(begin: 1.0, end: 2.5),
      builder: (context, child, value) {
      return Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: MediaQuery.of(context).size.width - 30,
            height: 150,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.1 * value),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ],
      );
    }
  );
}
}