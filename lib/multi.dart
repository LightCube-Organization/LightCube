import 'package:flutter/material.dart';

class Multi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multi Play",
      home: Scaffold(
        appBar: AppBar(
          title: Text('LightCube'),
        ),
        body: Center(
          child: const Text('Multi'),
        ),
      ),
    );
  }
}