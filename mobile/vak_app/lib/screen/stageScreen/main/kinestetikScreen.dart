import 'package:flutter/material.dart';
import 'package:GamiLearn/models/soal.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:audioplayers/audioplayers.dart';

class KinestetikScreen extends StatefulWidget {
  final Soal soal;
  final Function(String)? onJawabanSelesai;

  const KinestetikScreen({Key? key, required this.soal, this.onJawabanSelesai}) : super(key: key);

  @override
  State<KinestetikScreen> createState() => _KinestetikScreenState();
}

class _KinestetikScreenState extends State<KinestetikScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Map<String, String> choices = {};
  Map<String, String?> targetSlots = {};
  bool _isInitialized = false;
  bool isPlaying = false;
  bool isPressed = false;

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
      pasanganA: opsiA,
      pasanganB: opsiB,
      pasanganC: opsiC,
      pasanganD: opsiD,
    };

    targetSlots = {
      opsiA: null,
      opsiB: null,
      opsiC: null,
      opsiD: null,
    };

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

    Future<void> _playPause() async {
    if (widget.soal.audioPertanyaan == null) return;
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(widget.soal.audioPertanyaan!));
    }
    setState(() {
      isPlaying = !isPlaying;
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
        backgroundColor: LocalColor.primary,
        onPressed: _resetJawaban,
        child: const Icon(Icons.refresh,color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
            onPressed: _playPause,
            child: Image.asset(
              "assets/images/component/HiFi-Speaker.png",
              width: 40,
              height: 40,
            ),
          ),

            const SizedBox(width: 21),
            Expanded(
              child: Text(
                widget.soal.pertanyaan??"Cocokkan gambar dengan kata",
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
      final data = targetSlots[label];
      final isImage = data != null && (data.endsWith(".png") || data.endsWith(".jpg"));
      
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            // Hapus border di sini
            color: data != null ? Colors.green[200] : Colors.white,
          ),
          child: data == null
              ? Center(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: 
                    BoldTextStyle.textTheme.bodyLarge!.copyWith(color: LocalColor.primary), // Warna teks biru
                  ),
                )
              : isImage
                  ? (data.startsWith("http")
                      ? Image.network(data, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                      : Image.asset(data, fit: BoxFit.cover, width: double.infinity, height: double.infinity))
                  : Center(
                      child: Text(
                        data,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: Colors.blue), // Warna teks biru
                      ),
                    ),
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
    final isImage = label.endsWith(".png") || label.endsWith(".jpg");

    return Container(
      width: 150,
      height: 100,
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey[300] : Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        // child: isImage
        //     ? (label.startsWith("http")
        //         ? Image.network(label)
        //         : Image.asset(label))
        //     : Text(
        //         label,
        //         style: const TextStyle(fontSize: 18, color: Colors.white),
        //         textAlign: TextAlign.center,
        //       ),
        child: isImage
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: label.startsWith("http")
                  ? Image.network(label, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                  : Image.asset(label, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            )
          : Text(
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
        final opsiHuruf = _getHurufDariOpsi(kunci);
        final pasanganHuruf = _getHurufDariPasangan(nilai);
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

