// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:stilo/stilo.dart';
import './single.dart';
import './multi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Let's get started",
      home: Start(),
    );
  }
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('LightCube'),
          leading: addLeadingIcon(),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: StiloWidth.w48,
                height: StiloHeight.h12,
                child: ElevatedButton(
                  child: const Text('Single'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    onPrimary: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Single()),
                    );
                  },
              )),
              StiloSpacing.y10,
              Container(
                width: StiloWidth.w48,
                height: StiloHeight.h12,
                  child: ElevatedButton(
                    child: const Text('Multi'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        onPrimary: Colors.white,
                      ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Multi()),
                      );
                    },
              )),
            ]
          ),
        ),
    );
  }
}

Widget addLeadingIcon() {
  return new Container(
    padding: EdgeInsets.only(left: 10),
    height: 50.0,
    width: 50.0,
    child: new Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        new Image.asset(
          'images/logo.png',
          width: 50.0,
          height: 50.0,
        )
      ],
    ),
  );
}
