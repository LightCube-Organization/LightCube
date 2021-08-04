import 'package:flutter/material.dart';

class Single extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Single Play",
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('LightCube'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () => {},
                ),
              ],
            ),
            body: Container(
                child: Column(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  // 56はAppBarの高さ
                  height: (MediaQuery.of(context).size.height - 56) * 0.6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: CustomPaint(
                    painter: _MainPainter(),
                  )),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: (MediaQuery.of(context).size.height - 56) * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: GridView.extent(
                          // よくわからない
                          maxCrossAxisExtent: 200,
                          padding: const EdgeInsets.all(20),
                          childAspectRatio: 1.75,
                          children: [
                            Container(
                                child: CustomPaint(
                              painter: _Diamond(),
                            )),
                            Container(
                                child: CustomPaint(
                              painter: _Square(),
                            )),
                            Container(
                                child: CustomPaint(
                              painter: _LoopStart(),
                            )),
                            Container(
                                child: CustomPaint(
                              painter: _LoopEnd(),
                            )),
                            Container(
                                child: CustomPaint(
                              painter: _Oval(),
                            )),
                          ])),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: (MediaQuery.of(context).size.height - 56) * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                ],
              )
            ]))));
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
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    paint.color = Colors.grey;
    paint.strokeWidth = 10;
    canvas.drawLine(Offset(size.width / 2 - 75, 0),
        Offset(size.width / 2 - 75, size.height / 2 - 70), paint);
    canvas.drawLine(Offset(size.width / 2 - 75, size.height / 2 + 70),
        Offset(size.width / 2 - 75, size.height), paint);
    canvas.drawLine(Offset(size.width / 2 + 75, 0),
        Offset(size.width / 2 + 75, size.height / 2 - 70), paint);
    canvas.drawLine(Offset(size.width / 2 + 75, size.height / 2 + 70),
        Offset(size.width / 2 + 75, size.height), paint);
    canvas.drawLine(Offset(0, size.height / 2 - 75),
        Offset(size.width / 2 - 75, size.height / 2 - 75), paint);
    canvas.drawLine(Offset(size.width / 2 + 75, size.height / 2 - 75),
        Offset(size.width, size.height / 2 - 75), paint);
    canvas.drawLine(Offset(0, size.height / 2 + 75),
        Offset(size.width / 2 - 75, size.height / 2 + 75), paint);
    canvas.drawLine(Offset(size.width / 2 + 75, size.height / 2 + 75),
        Offset(size.width, size.height / 2 + 75), paint);
    paint.color = Colors.white;
    paint.strokeWidth = 5;
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    paint.color = Colors.black;
    canvas.drawRect(
        Rect.fromLTWH(size.width / 2 - 70, size.height / 2 - 70, 140, 140),
        paint);
    paint.color = Colors.blue;

    // 車
    canvas.drawRect(Rect.fromLTWH(0, size.height / 2 - 60, 70, 50), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Diamond extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.orange;

    // 枠だけにする場合はこれ
    //paint.style = PaintingStyle.stroke;

    // 菱形
    final diamond = Path()
      ..moveTo(
        0,
        40,
      )
      ..lineTo(
        75,
        0,
      )
      ..lineTo(
        150,
        40,
      )
      ..lineTo(
        75,
        80,
      )
      ..lineTo(
        0,
        40,
      );
    canvas.drawPath(diamond, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Square extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.teal;

    // 枠だけにする場合はこれ
    //paint.style = PaintingStyle.stroke;

    // 四角形
    canvas.drawRect(Rect.fromLTWH(0, 0, 150, 50), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _LoopStart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.deepOrange;

    // 枠だけにする場合はこれ
    //paint.style = PaintingStyle.stroke;

    // 繰り返しの初めのほうのやつ
    final start = Path()
      ..moveTo(
        20,
        0,
      )
      ..lineTo(
        0,
        20,
      )
      ..lineTo(
        0,
        50,
      )
      ..lineTo(
        150,
        50,
      )
      ..lineTo(
        150,
        20,
      )
      ..lineTo(
        130,
        0,
      )
      ..lineTo(
        20,
        0,
      );
    canvas.drawPath(start, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _LoopEnd extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.deepOrange;

    // 枠だけにする場合はこれ
    //paint.style = PaintingStyle.stroke;

    // 繰り返しの終わりのほうのやつ
    final end = Path()
      ..moveTo(
        0,
        0,
      )
      ..lineTo(
        0,
        30,
      )
      ..lineTo(
        20,
        50,
      )
      ..lineTo(
        130,
        50,
      )
      ..lineTo(
        150,
        30,
      )
      ..lineTo(
        150,
        0,
      )
      ..lineTo(
        0,
        0,
      );
    canvas.drawPath(end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Oval extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.lightBlue;

    // 枠だけにする場合はこれ
    //paint.style = PaintingStyle.stroke;

    // 楕円
    canvas.drawOval(Rect.fromLTWH(0, 0, 150, 60), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
