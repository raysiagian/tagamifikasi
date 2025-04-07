import 'package:flutter/material.dart';
import 'package:vak_app/models/mataPelajaran.dart';

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
      body: Center(
        child: Text("Tampilkan detail statistik untuk ${widget.mataPelajaran.nama}"),
      ),
    );
  }
}
