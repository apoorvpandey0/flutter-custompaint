import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Custom Paint"),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => CustomPaint(
            painter: ShapesPainter(),
            child: Container(
              child: Text("Hi"),
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              // color: Colors.greenAccent,
            ),
          ),
        ),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
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
    canvas.drawCircle(center, 80, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
