import 'package:flutter/material.dart';
import './main.dart';

class Multi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multi Play",
      home: Scaffold(
        appBar: AppBar(
          title: Text('LightCube'),
          leading: addLeadingIcon(),
        ),
        body: Center(
          child: const Text('Multi'),
        ),
      ),
    );
  }
}