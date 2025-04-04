import 'package:flutter/material.dart';
import 'dart:math';

import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/localColor.dart';

class KinestetikScreen extends StatefulWidget {
  final Soal soal;
  KinestetikScreen({Key? key, required this.soal}) : super(key: key);

  @override
  State<KinestetikScreen> createState() => _KinestetikScreenState();
}

class _KinestetikScreenState extends State<KinestetikScreen> {
  
  late Map<String, String> choices;
  late Map<String, String?> targetSlots;
  int seed = 0;

  @override
  void initState() {
    super.initState();
    choices = {
     widget.soal.opsiA ?? "Opsional A": widget.soal.pasanganA ?? "Pasangan A",
      widget.soal.opsiB ?? "Opsional B": widget.soal.pasanganB ?? "Pasangan B",
      widget.soal.opsiC ?? "Opsional C": widget.soal.pasanganC ?? "Pasangan C",
      widget.soal.opsiD ?? "Opsional D": widget.soal.pasanganD ?? "Pasangan D",
    };
    targetSlots = {
      widget.soal.pasanganA ?? "Pasangan A": null,
      widget.soal.pasanganB ?? "Pasangan B": null,
      widget.soal.pasanganC ?? "Pasangan C": null,
      widget.soal.pasanganD ?? "Pasangan D": null,
    };
  }

  @override
  Widget build(BuildContext context) {
    List<String> emojis = choices.keys.toList();
    emojis.shuffle(Random(seed));

    return Scaffold(
      backgroundColor: LocalColor.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            seed = Random().nextInt(100);
            targetSlots.updateAll((key, value) => null);
          });
        },
        child: const Icon(Icons.refresh),
      ),
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
                    if (choices[emoji] == nama) {
                      targetSlots[nama] = emoji;
                    }
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