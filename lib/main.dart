import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double gdx;
  double gdy;
  double gdr = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              gdr = 100;
            });
          },
        ),
        // appBar: AppBar(
        //   title: Text("Custom Paint"),
        // ),
        body: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                gdx = details.globalPosition.dx;
                gdy = details.globalPosition.dy;
              });

              // print(gdx);
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              var newPosition = details.focalPoint;
              var newRotation = details.rotation;
              var newScale = details.scale;
              // print(newPosition);
              print(newScale);
              setState(() {
                print(gdr);
                gdr = newScale * 50;
                print(gdr);
              });
              //scale and rotation now available
            },
            child: CustomPaint(
              painter: ShapesPainter(gdx, gdy, gdr),
              child: Container(
                child: Text("Hi"),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                // color: Colors.greenAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final dx;
  final dy;
  final dr;
  ShapesPainter(this.dx, this.dy, this.dr);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.yellow;

    // create a path
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    // close the path to form a bounded shape
    path.close();

    canvas.drawPath(path, paint);

    // set the paint color to be white
    paint.color = Colors.brown;

    // Create a rectangle with size and width same as the canvas
    var rect = Rect.fromLTWH(100, 100, size.width, size.height);

    // draw the rectangle using the paint
    canvas.drawRect(rect, paint);

    // set the color property of the paint
    paint.color = Colors.blueAccent;

    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(size.width / 2, size.height / 2);

    // draw the circle on centre of canvas having radius 75.0
    canvas.drawCircle(Offset(dx.toDouble(), dy.toDouble()), dr, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
