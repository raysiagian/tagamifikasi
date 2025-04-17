import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class KinestetikScreen extends StatefulWidget {
  final Soal soal;
  final Function(String)? onJawabanSelesai;

  const KinestetikScreen({Key? key, required this.soal, this.onJawabanSelesai}) : super(key: key);

  @override
  State<KinestetikScreen> createState() => _KinestetikScreenState();
}

class _KinestetikScreenState extends State<KinestetikScreen> {
  Map<String, String> choices = {};
  Map<String, String?> targetSlots = {};
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    final opsiA = widget.soal.opsiA ?? "Opsi A";
    final opsiB = widget.soal.opsiB ?? "Opsi B";
    final opsiC = widget.soal.opsiC ?? "Opsi C";
    final opsiD = widget.soal.opsiD ?? "Opsi D";

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
        onPressed: _resetJawaban,
        child: const Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeader(),

            const SizedBox(height: 20),

            _buildTargetGrid(),

            const SizedBox(height: 40),

            _buildOpsiGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
    );
  }

  Widget _buildTargetGrid() {
    final pasangan = targetSlots.keys.toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            _buildTargetBox(pasangan[0]),
            const SizedBox(height: 10),
            _buildTargetBox(pasangan[1]),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            _buildTargetBox(pasangan[2]),
            const SizedBox(height: 10),
            _buildTargetBox(pasangan[3]),
          ],
        ),
      ],
    );
  }

  Widget _buildTargetBox(String label) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          targetSlots[label] = data;
          if (targetSlots.values.every((val) => val != null)) {
            final jawaban = _buildJawaban();
            widget.onJawabanSelesai?.call(jawaban);
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 150,
          height: 60,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black, width: 1.5),
            color: targetSlots[label] != null ? Colors.green[200] : Colors.white,
          ),
          child: Text(
            targetSlots[label] ?? label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        );
      },
    );
  }

  Widget _buildOpsiGrid() {
    final opsi = choices.keys.toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            _buildOpsiItem(opsi[0]),
            const SizedBox(height: 10),
            _buildOpsiItem(opsi[1]),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            _buildOpsiItem(opsi[2]),
            const SizedBox(height: 10),
            _buildOpsiItem(opsi[3]),
          ],
        ),
      ],
    );
  }

  Widget _buildOpsiItem(String opsi) {
    bool isUsed = targetSlots.containsValue(opsi);

    return Draggable<String>(
      data: opsi,
      feedback: _buildDraggableItem(opsi, isDragging: true),
      childWhenDragging: Opacity(opacity: 0.3, child: _buildDraggableItem(opsi)),
      child: isUsed ? const SizedBox.shrink() : _buildDraggableItem(opsi),
    );
  }

  Widget _buildDraggableItem(String label, {bool isDragging = false}) {
    return Container(
      width: 150,
      height: 60,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey[300] : Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _resetJawaban() {
    setState(() {
      targetSlots.updateAll((key, value) => null);
    });
  }

  String _buildJawaban() {
    Map<String, String> jawaban = {};
    targetSlots.forEach((kunci, nilai) {
      if (nilai != null) {
        final opsiHuruf = _getHurufDariOpsi(nilai);
        final pasanganHuruf = _getHurufDariPasangan(kunci);
        jawaban[opsiHuruf] = pasanganHuruf;
      }
    });
    return "{${jawaban.entries.map((e) => '"${e.key}":"${e.value}"').join(",")}}";
  }

  String _getHurufDariOpsi(String opsi) {
    if (opsi == widget.soal.opsiA) return "A";
    if (opsi == widget.soal.opsiB) return "B";
    if (opsi == widget.soal.opsiC) return "C";
    if (opsi == widget.soal.opsiD) return "D";
    return opsi;
  }

  String _getHurufDariPasangan(String pasangan) {
    if (pasangan == widget.soal.pasanganA) return "A";
    if (pasangan == widget.soal.pasanganB) return "B";
    if (pasangan == widget.soal.pasanganC) return "C";
    if (pasangan == widget.soal.pasanganD) return "D";
    return pasangan;
  }
}
