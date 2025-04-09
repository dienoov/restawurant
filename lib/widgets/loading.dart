import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        Theme.of(context).brightness == Brightness.dark
            ? 'assets/loading.dark.json'
            : 'assets/loading.light.json',
        width: 160,
      ),
    );
  }
}
