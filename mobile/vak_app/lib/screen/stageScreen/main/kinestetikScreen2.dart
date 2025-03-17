import 'package:flutter/material.dart';
import 'dart:math';

class KinestetikScreen2 extends StatefulWidget {
  const KinestetikScreen2({super.key});

  @override
  State<KinestetikScreen2> createState() => _KinestetikScreen2State();
}

class _KinestetikScreen2State extends State<KinestetikScreen2>
    with SingleTickerProviderStateMixin {
  final Random random = Random();
  double targetX = 0.0;
  double targetY = 0.0;
  int score = 0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  Color targetColor = Colors.blueAccent;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveTarget();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _moveTarget() {
    setState(() {
      double maxX = MediaQuery.of(context).size.width - 100;
      double maxY = MediaQuery.of(context).size.height - 200;

      targetX = random.nextDouble() * maxX;
      targetY = random.nextDouble() * maxY;

      targetX = targetX.clamp(0, maxX);
      targetY = targetY.clamp(0, maxY);

      targetColor = Colors.blueAccent.withOpacity(0.8);
    });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Tangkap Bola Biru!',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.blue.shade600],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            left: targetX,
            top: targetY,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    score++;
                    _moveTarget();
                  });
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.celebration, size: 80, color: Colors.blue),
                          const SizedBox(height: 10),
                          const Text(
                            'Hebat! 🎉',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 600), () {
                    Navigator.of(context).pop();
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: targetColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                'Skor: $score',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
