import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/boldTextStyle.dart';
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

  void _initializeData() {
    final timestamp = DateTime.now().microsecondsSinceEpoch;

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
      pasanganA: null,
      pasanganB: null,
      pasanganC: null,
      pasanganD: null,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffleEmojis,
        child: const Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header or instructions
            Container(
              width: double.infinity,
              height: 102,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 29),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LocalColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () {
                        print("Audio dimainkan: ${widget.soal.audioPertanyaan}");
                      },
                      child: Image.asset(
                        "assets/images/component/HiFi-Speaker.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 21),
                    Expanded(
                      child: Text(
                        "Cocokkan Pasangan",
                        style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                          color: LocalColor.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Target grid for dropping options
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.5, // lebar lebih dari tinggi
              physics: const NeverScrollableScrollPhysics(),
              children: targetSlots.keys.map((nama) {
                return DragTarget<String>(
                  onAccept: (emoji) {
                    setState(() {
                      targetSlots[nama] = emoji;

                      bool semuaTerisi = targetSlots.values.every((v) => v != null);
                      if (semuaTerisi) {
                        final jawaban = _buildJawaban();
                        widget.onJawabanSelesai?.call(jawaban);
                      }
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1.5),
                        color: targetSlots[nama] != null ? Colors.green[200] : Colors.white,
                      ),
                      child: Text(
                        targetSlots[nama] ?? nama,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // Draggable options
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2, // sedikit lebih kecil supaya tidak overflow
              physics: const NeverScrollableScrollPhysics(),
              children: emojis.map((emoji) {
                return Draggable<String>(
                  data: emoji,
                  feedback: _buildDraggableItem(emoji, isDragging: true),
                  childWhenDragging: Opacity(opacity: 0.3, child: _buildDraggableItem(emoji)),
                  child: targetSlots.containsValue(emoji)
                      ? const SizedBox.shrink()
                      : _buildDraggableItem(emoji),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableItem(String emoji, {bool isDragging = false}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey[300] : Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _shuffleEmojis() {
    setState(() {
      seed = Random().nextInt(100);
      emojis.shuffle(Random(seed));
      targetSlots.updateAll((key, value) => null);
    });
  }

  // Menyusun jawaban dalam format yang diinginkan
  String _buildJawaban() {
    Map<String, String> jawaban = {};
    targetSlots.forEach((key, value) {
      if (value != null) {
        final opsiHuruf = _getHurufDariOpsi(value);
        final pasanganHuruf = _getHurufDariPasangan(key);
        jawaban[opsiHuruf] = pasanganHuruf;
      }
    });
    return "{${jawaban.entries.map((e) => '"${e.key}":"${e.value}"').join(",")}}";
  }

  // Fungsi untuk mendapatkan huruf opsi
  String _getHurufDariOpsi(String opsi) {
    if (opsi == widget.soal.opsiA) return "A";
    if (opsi == widget.soal.opsiB) return "B";
    if (opsi == widget.soal.opsiC) return "C";
    if (opsi == widget.soal.opsiD) return "D";
    return opsi;
  }

  // Fungsi untuk mendapatkan huruf pasangan
  String _getHurufDariPasangan(String pasangan) {
    if (pasangan == widget.soal.pasanganA) return "A";
    if (pasangan == widget.soal.pasanganB) return "B";
    if (pasangan == widget.soal.pasanganC) return "C";
    if (pasangan == widget.soal.pasanganD) return "D";
    return pasangan;
  }
}
