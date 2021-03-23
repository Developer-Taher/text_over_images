import 'package:flutter/material.dart';

class Imagepage extends StatelessWidget {
  final imageBytes;
  const Imagepage({Key key, this.imageBytes}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.memory(
        imageBytes,
        // width: 350,
        fit: BoxFit.cover,
      ),
    );
  }
}
