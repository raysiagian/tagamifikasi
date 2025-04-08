import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vak_app/style/localColor.dart';

class LevelScoreList extends StatefulWidget {
  const LevelScoreList({super.key});

  @override
  State<LevelScoreList> createState() => _LevelScoreListState();
}

class _LevelScoreListState extends State<LevelScoreList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          // ganti ketika sudah memiliki data
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: LocalColor.primary),
                ),
              ),
              child: Row(
                children: [
                  Text("Nama Level"),
                  const SizedBox(width: 40),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.star,
                          color: Colors.amber,
                          size: 30.0,
                        ),
                         Icon(
                          CupertinoIcons.star,
                          color: Colors.amber,
                          size: 30.0,
                        ),
                         Icon(
                          CupertinoIcons.star,
                          color: Colors.amber,
                          size: 30.0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}