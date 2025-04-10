import 'package:flutter/material.dart';
import 'dart:math';

import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/localColor.dart';

class KinestetikScreen extends StatefulWidget {
  final Soal soal;
  final Function(String)? onJawabanSelesai;

  KinestetikScreen({Key? key, required this.soal, this.onJawabanSelesai}) : super(key: key);

  @override
  State<KinestetikScreen> createState() => _KinestetikScreenState();
}

class _KinestetikScreenState extends State<KinestetikScreen> {
  Map<String, String> choices = {};
  Map<String, String?> targetSlots = {};
  List<String> emojis = [];
  int seed = 0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Function to safely initialize data
  void _initializeData() {
    final timestamp = DateTime.now().microsecondsSinceEpoch;

    // Ensure all options and pairings are safely initialized
    final opsiA = widget.soal.opsiA ?? "Opsional A $timestamp";
    final opsiB = widget.soal.opsiB ?? "Opsional B ${timestamp + 1}";
    final opsiC = widget.soal.opsiC ?? "Opsional C ${timestamp + 2}";
    final opsiD = widget.soal.opsiD ?? "Opsional D ${timestamp + 3}";

    final pasanganA = widget.soal.pasanganA ?? "Pasangan A";
    final pasanganB = widget.soal.pasanganB ?? "Pasangan B";
    final pasanganC = widget.soal.pasanganC ?? "Pasangan C";
    final pasanganD = widget.soal.pasanganD ?? "Pasangan D";

    choices = {
      opsiA: pasanganA,
      opsiB: pasanganB,
      opsiC: pasanganC,
      opsiD: pasanganD,
    };

    targetSlots = {
      if (widget.soal.pasanganA != null) widget.soal.pasanganA! : null,
      if (widget.soal.pasanganB != null) widget.soal.pasanganB! : null,
      if (widget.soal.pasanganC != null) widget.soal.pasanganC! : null,
      if (widget.soal.pasanganD != null) widget.soal.pasanganD! : null,
    };

    emojis = choices.keys.toList();
    emojis.shuffle(Random(seed));

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: LocalColor.transparent,
      floatingActionButton: (widget.soal.pasanganA != null ||
              widget.soal.pasanganB != null ||
              widget.soal.pasanganC != null ||
              widget.soal.pasanganD != null)
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  seed = Random().nextInt(100);
                  emojis.shuffle(Random(seed));
                  targetSlots = {
                    if (widget.soal.pasanganA != null) widget.soal.pasanganA! : null,
                    if (widget.soal.pasanganB != null) widget.soal.pasanganB! : null,
                    if (widget.soal.pasanganC != null) widget.soal.pasanganC! : null,
                    if (widget.soal.pasanganD != null) widget.soal.pasanganD! : null,
                  };
                });
              },
              child: const Icon(Icons.refresh),
            )
          : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: targetSlots.keys.map((nama) {
              return DragTarget<String>(  
                onAccept: (emoji) {
                  setState(() {
                    targetSlots[nama] = emoji;

                    bool semuaTerisi = targetSlots.values.every((v) => v != null);
                    bool semuaBenar = targetSlots.entries.every((entry) {
                      final pasangan = entry.key;
                      final opsi = entry.value;
                      return opsi != null && choices[opsi] == pasangan;
                    });

                    if (semuaTerisi && semuaBenar) {
                      final jawaban = targetSlots.entries
                          .map((e) => "${e.value}:${e.key}")
                          .join(",");
                      widget.onJawabanSelesai?.call(jawaban);
                    }
                    print("Cek pasangan: $emoji -> $nama");
                    print("Semua terisi: $semuaTerisi, Semua benar: $semuaBenar");
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 100,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                      color: targetSlots[nama] != null ? Colors.green[200] : Colors.white,
                    ),
                    child: Text(
                      targetSlots[nama] ?? nama,
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: emojis.map((emoji) {
              return Draggable<String>(  
                data: emoji,
                feedback: _buildDraggableItem(emoji, isDragging: true),
                childWhenDragging: Opacity(opacity: 0.3, child: _buildDraggableItem(emoji)),
                child: targetSlots.containsValue(emoji) ? const SizedBox.shrink() : _buildDraggableItem(emoji),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableItem(String emoji, {bool isDragging = false}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey[300] : Colors.blueAccent,
        shape: BoxShape.circle,
      ),
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}