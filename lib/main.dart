import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dibujar Figuras',
      home: DrawingApp(),
    );
  }
}

class DrawingApp extends StatefulWidget {
  @override
  _DrawingAppState createState() => _DrawingAppState();
}

class _DrawingAppState extends State<DrawingApp> {
  String _figure = "";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dibujar Figuras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ingrese una figura',
              ),
              onChanged: (value) {
                setState(() {
                  _figure = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.clear();
                _drawFigure(_figure);
              },
              child: Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }

  void _drawFigure(String figure) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (figure == "triangulo") {
          return AlertDialog(
            title: Text('Triángulo'),
            content: CustomPaint(
              size: Size(100, 100),
              painter: TrianglePainter(),
            ),
          );
        } else if (figure == "cuadrado") {
          return AlertDialog(
            title: Text('Cuadrado'),
            content: CustomPaint(
              size: Size(100, 100),
              painter: SquarePainter(),
            ),
          );
        } else {
          return AlertDialog(
            title: Text('Figura no encontrada'),
            content: Text('Por favor, ingrese "triangulo" o "cuadrado".'),
          );
        }
      },
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
