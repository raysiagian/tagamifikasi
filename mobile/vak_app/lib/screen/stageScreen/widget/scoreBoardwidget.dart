import 'package:flutter/material.dart';
import 'package:vak_app/style/localColor.dart';

class ScoreBoardWidget extends StatefulWidget {
  const ScoreBoardWidget({super.key});

  @override
  State<ScoreBoardWidget> createState() => _ScoreBoardWidgetState();
}

class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: LocalColor.brown,
      ),
      child: Center(
        child: Column(
          children: [
            Text('Level Selesai'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
              child: Container(
                height: 350,
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: LocalColor.beige,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
