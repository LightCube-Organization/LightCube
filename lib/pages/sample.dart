import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/layers.dart';
import 'package:flame/components.dart';
import 'package:graphite/core/matrix.dart';
import 'package:graphite/core/typings.dart';
import 'package:graphite/graphite.dart';

// JSONで渡す、minifyしないとStringで取得できない
const flowchart =
    '[{"id":"Start","next":["Red A 5sec"]},{"id":"Red A 5sec","next":["Green A 5sec"]},{"id":"Green A 5sec","next":["End"]},{"id":"End","next":[]}]';

class Sample extends StatelessWidget {
  final myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    var viewchart = nodeInputFromJson(flowchart);
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
                Padding(
                  padding: EdgeInsets.only(right:10),
                  child: IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () => {},
                  )
                ),
                Padding(
                    padding: EdgeInsets.only(right:10),
                    child: IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: () => {},
                    )
                ),
              ],
            ),
            body: Container(
                child: Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height:(MediaQuery.of(context).size.height - 56) * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: GameWidget(
                  game: myGame,
                ),
              ),
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
                    child: Container(
                      child: DirectGraph(
                        list: viewchart,
                        cellWidth: 130.0,
                        cellPadding: 24.0,
                        orientation: MatrixOrientation.Vertical,
                      ),
                    ),
                  ),
                ],
              )
            ]))));
  }
}

class MyGame extends Game {
  static const int squareSpeed = 400;
  static final squarePaint = Paint()..color = Colors.lightBlue;
  late Rect squarePos;
  late Layer gameLayer;
  int squareDirection = 1;

  // 四角形（車）初期位置
  @override
  Future<void> onLoad() async {
    squarePos = Rect.fromLTWH(0, size.y / 2 - 60, 70, 50);
  }

  // 動く四角形の速度
  @override
  void update(double dt) {
    squarePos = squarePos.translate(squareSpeed * squareDirection * dt, 0);
    if (squareDirection == 1 && squarePos.right > size.x) {
      squareDirection = -1;
    } else if (squareDirection == -1 && squarePos.left < 0) {
      squareDirection = 1;
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 140;

    // 道路と枠線
    canvas.drawLine(
        Offset(size.x / 2, 0), Offset(size.x / 2, size.y), paint);
    canvas.drawLine(
        Offset(0, size.y / 2), Offset(size.x, size.y / 2), paint);
    paint.color = Colors.grey;
    paint.strokeWidth = 10;
    canvas.drawLine(Offset(size.x / 2 - 75, 0),
        Offset(size.x / 2 - 75, size.y / 2 - 70), paint);
    canvas.drawLine(Offset(size.x / 2 - 75, size.y / 2 + 70),
        Offset(size.x / 2 - 75, size.y), paint);
    canvas.drawLine(Offset(size.x / 2 + 75, 0),
        Offset(size.x / 2 + 75, size.y / 2 - 70), paint);
    canvas.drawLine(Offset(size.x / 2 + 75, size.y / 2 + 70),
        Offset(size.x / 2 + 75, size.y), paint);
    canvas.drawLine(Offset(0, size.y / 2 - 75),
        Offset(size.x / 2 - 75, size.y / 2 - 75), paint);
    canvas.drawLine(Offset(size.x / 2 + 75, size.y / 2 - 75),
        Offset(size.x, size.y / 2 - 75), paint);
    canvas.drawLine(Offset(0, size.y / 2 + 75),
        Offset(size.x / 2 - 75, size.y / 2 + 75), paint);
    canvas.drawLine(Offset(size.x / 2 + 75, size.y / 2 + 75),
        Offset(size.x, size.y / 2 + 75), paint);
    paint.color = Colors.white;
    paint.strokeWidth = 5;
    canvas.drawLine(
        Offset(size.x / 2, 0), Offset(size.x / 2, size.y), paint);
    canvas.drawLine(
        Offset(0, size.y / 2), Offset(size.x, size.y / 2), paint);
    paint.color = Colors.black;
    canvas.drawRect(
        Rect.fromLTWH(size.x / 2 - 70, size.y / 2 - 70, 140, 140),
        paint);

    // 四角形
    canvas.drawRect(squarePos, squarePaint);
  }


  // 背景色
  @override
  Color backgroundColor() => const Color(0xFFFFFF);
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
