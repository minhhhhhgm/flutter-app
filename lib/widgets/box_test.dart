import 'package:flutter/material.dart';

class BoxTest extends StatelessWidget {
  final double width;

  const BoxTest({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.red
      ),
    );
  }
}
