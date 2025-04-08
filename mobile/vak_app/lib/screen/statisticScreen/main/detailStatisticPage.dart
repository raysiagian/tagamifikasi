import 'package:flutter/material.dart';
import 'package:vak_app/models/mataPelajaran.dart';
import 'package:vak_app/screen/statisticScreen/widget/levelScoreListWidget.dart';

class DetailStatisticPage extends StatefulWidget {
  final MataPelajaran mataPelajaran;

  const DetailStatisticPage({super.key, required this.mataPelajaran});

  @override
  State<DetailStatisticPage> createState() => _DetailStatisticPageState();
}

class _DetailStatisticPageState extends State<DetailStatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.mataPelajaran.nama}")),
      body: Container(
           decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background/HiFi-Statistic Background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
            child: LevelScoreList(),
          ),
        ),
    );
  }
}
