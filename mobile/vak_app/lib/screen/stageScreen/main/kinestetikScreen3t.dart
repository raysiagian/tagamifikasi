import 'package:flutter/material.dart';
import 'dart:math';

class KinestetikScreen3 extends StatefulWidget {
  const KinestetikScreen3({super.key});

  @override
  State<KinestetikScreen3> createState() => _KinestetikScreen3State();
}

class _KinestetikScreen3State extends State<KinestetikScreen3>
    with SingleTickerProviderStateMixin {
  final Random random = Random();
  double targetX = 0.0;
  double targetY = 0.0;
  int score = 0;
  bool isInitialized = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
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
      double maxX = MediaQuery.of(context).size.width - 50;
      double maxY = MediaQuery.of(context).size.height - 150;

      targetX = random.nextDouble() * maxX;
      targetY = random.nextDouble() * maxY;

      targetX = targetX.clamp(0, maxX);
      targetY = targetY.clamp(0, maxY);
    });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tangkap Bola!'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: targetX,
            top: targetY,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    score++;
                    _moveTarget();
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              'Skor: $score',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
