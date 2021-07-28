import 'package:flutter/material.dart';
import 'dart:math';

class Single extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Single Play",
        home: Scaffold(
          appBar: AppBar(
            title: Text('LightCube'),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  // 56はAppBarの高さ
                  height: (MediaQuery.of(context).size.height - 56) * 0.6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: CustomPaint(
                    painter: _MainPainter(),
                  )
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: (MediaQuery.of(context).size.height - 56) * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                        child: CustomPaint(
                          painter: _SelectPainter(),
                        )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: (MediaQuery.of(context).size.height - 56) * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ],
                )
              ]
            )
          )
        )
    );
  }
}

class _MainPainter extends CustomPainter {
  //雑描画
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 140;

    // 道路と枠線
    canvas.drawLine(Offset(size.width / 2 , 0),Offset(size.width / 2, size.height),paint);
    canvas.drawLine(Offset(0, size.height / 2),Offset(size.width, size.height / 2),paint);
    paint.color = Colors.grey;
    paint.strokeWidth = 10;
    canvas.drawLine(Offset(size.width / 2 - 75 , 0),Offset(size.width / 2 - 75, size.height / 2 - 70),paint);
    canvas.drawLine(Offset(size.width / 2 - 75 , size.height / 2 + 70),Offset(size.width / 2 - 75, size.height),paint);
    canvas.drawLine(Offset(size.width / 2 + 75 , 0),Offset(size.width / 2 + 75, size.height / 2 - 70),paint);
    canvas.drawLine(Offset(size.width / 2 + 75 , size.height / 2 + 70),Offset(size.width / 2 + 75, size.height),paint);
    canvas.drawLine(Offset(0 , size.height / 2 - 75),Offset(size.width / 2 - 75, size.height / 2 - 75),paint);
    canvas.drawLine(Offset(size.width / 2 + 75 , size.height / 2 - 75),Offset(size.width, size.height / 2 - 75),paint);
    canvas.drawLine(Offset(0 , size.height / 2 + 75),Offset(size.width / 2 - 75, size.height / 2 + 75),paint);
    canvas.drawLine(Offset(size.width / 2 + 75 , size.height / 2 + 75),Offset(size.width, size.height / 2 + 75),paint);
    paint.color = Colors.white;
    paint.strokeWidth = 5;
    canvas.drawLine(Offset(size.width / 2 , 0),Offset(size.width / 2, size.height),paint);
    canvas.drawLine(Offset(0, size.height / 2),Offset(size.width, size.height / 2),paint);
    paint.color = Colors.black;
    canvas.drawRect(Rect.fromLTWH(size.width / 2 - 70, size.height / 2 - 70, 140, 140), paint);
    paint.color = Colors.blue;

    // 車
    canvas.drawRect(Rect.fromLTWH(0, size.height / 2 - 60, 70, 50), paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _SelectPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.orange;
    paint.strokeWidth = 1.0;

    // 枠だけにする場合はこれ
    //paint.style = PaintingStyle.stroke;

    // 菱形
    final diamond = Path()
      ..moveTo(
        20,
        60,
      )
      ..lineTo(
        95,
        20,
      )
      ..lineTo(
        170,
        60,
      )
      ..lineTo(
        95,
        100,
      )
      ..lineTo(
        20,
        60,
      );
    canvas.drawPath(diamond, paint);

    // 四角形
    paint.color = Colors.teal;
    canvas.drawRect(Rect.fromLTWH(210, 30, 150, 50), paint);

    // 繰り返しの初めのほうのやつ
    paint.color = Colors.deepOrange;
    final start = Path()
      ..moveTo(
        40,
        120,
      )
      ..lineTo(
        20,
        140,
      )
      ..lineTo(
        20,
        170,
      )
      ..lineTo(
        170,
        170,
      )
      ..lineTo(
        170,
        140,
      )
      ..lineTo(
        150,
        120,
      )
      ..lineTo(
        40,
        120,
      );
    canvas.drawPath(start, paint);

    // 繰り返しの終わりのほうのやつ
    final end = Path()
      ..moveTo(
        210,
        120,
      )
      ..lineTo(
        210,
        150,
      )
      ..lineTo(
        230,
        170,
      )
      ..lineTo(
        340,
        170,
      )
      ..lineTo(
        360,
        150,
      )
      ..lineTo(
        360,
        120,
      )
      ..lineTo(
        210,
        120,
      );
    canvas.drawPath(end, paint);

    // 楕円
    paint.color = Colors.lightBlue;
    canvas.drawOval(Rect.fromLTWH(20, 200, 150, 60), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}