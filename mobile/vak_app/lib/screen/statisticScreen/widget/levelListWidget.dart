import 'package:flutter/material.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class LevelListWidget extends StatefulWidget {
  const LevelListWidget({super.key});

  @override
  State<LevelListWidget> createState() => _LevelListWidgetState();
}

class _LevelListWidgetState extends State<LevelListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:LocalColor.primary),
                  )
                ),
                child: Row(
                  children: [
                    Text(
                      'Level 1',
                      style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                        color: LocalColor.primary,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}