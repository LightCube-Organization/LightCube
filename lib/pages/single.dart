import 'package:flutter/material.dart';

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
                    painter: _SamplePainter(),
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

class _SamplePainter extends CustomPainter {
  //雑描画
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 140;
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}