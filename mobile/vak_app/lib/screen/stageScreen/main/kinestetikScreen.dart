import 'package:flutter/material.dart';
import 'dart:math';

class KinestetikScreen extends StatefulWidget {
  const KinestetikScreen({super.key});

  @override
  State<KinestetikScreen> createState() => _KinestetikScreenState();
}

class _KinestetikScreenState extends State<KinestetikScreen> {
double ballX = 0;
  double ballY = 0;
  double targetX = 100;
  double targetY = 400;
  bool isInsideTarget = false;

  void _updatePosition(DragUpdateDetails details) {
    setState(() {
      ballX += details.delta.dx;
      ballY += details.delta.dy;
    });
    _checkTarget();
  }

  void _checkTarget() {
    double dx = (ballX - targetX).abs();
    double dy = (ballY - targetY).abs();
    if (dx < 50 && dy < 50) {
      setState(() {
        isInsideTarget = true;
      });
    }
  }

  void _resetGame() {
    setState(() {
      ballX = Random().nextDouble() * 300;
      ballY = Random().nextDouble() * 500;
      isInsideTarget = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pertanyaan")),
      body: Stack(
        children: [
          Positioned(
            left: ballX,
            top: ballY,
            child: GestureDetector(
              onPanUpdate: _updatePosition,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            left: targetX,
            top: targetY,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isInsideTarget ? Colors.green : Colors.red,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 50,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Seret bola biru ke dalam kotak merah!\nAyo latih gerakan tanganmu!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (isInsideTarget)
            Center(
              child: ElevatedButton(
                onPressed: _resetGame,
                child: Text("Main Lagi!"),
              ),
            ),
        ],
     ),
    );
  }
}