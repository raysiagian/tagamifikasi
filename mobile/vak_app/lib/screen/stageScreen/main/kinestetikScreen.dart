// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:vak_app/models/soal.dart';
// import 'package:vak_app/style/localColor.dart';

// class KinestetikScreen extends StatefulWidget {
//   final Soal soal;
//   final Function(String)? onJawabanSelesai;

//   KinestetikScreen({Key? key, required this.soal, this.onJawabanSelesai}) : super(key: key);

//   @override
//   State<KinestetikScreen> createState() => _KinestetikScreenState();
// }

// class _KinestetikScreenState extends State<KinestetikScreen> {
//   Map<String, String> choices = {};
//   Map<String, String?> targetSlots = {};
//   List<String> emojis = [];
//   int seed = 0;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }

//   // Function to safely initialize data
//   void _initializeData() {
//     final timestamp = DateTime.now().microsecondsSinceEpoch;

//     // Ensure all options and pairings are safely initialized
//     final opsiA = widget.soal.opsiA ?? "Opsional A $timestamp";
//     final opsiB = widget.soal.opsiB ?? "Opsional B ${timestamp + 1}";
//     final opsiC = widget.soal.opsiC ?? "Opsional C ${timestamp + 2}";
//     final opsiD = widget.soal.opsiD ?? "Opsional D ${timestamp + 3}";

//     final pasanganA = widget.soal.pasanganA ?? "Pasangan A";
//     final pasanganB = widget.soal.pasanganB ?? "Pasangan B";
//     final pasanganC = widget.soal.pasanganC ?? "Pasangan C";
//     final pasanganD = widget.soal.pasanganD ?? "Pasangan D";

//     choices = {
//       opsiA: pasanganA,
//       opsiB: pasanganB,
//       opsiC: pasanganC,
//       opsiD: pasanganD,
//     };

//     targetSlots = {
//       if (widget.soal.pasanganA != null) widget.soal.pasanganA! : null,
//       if (widget.soal.pasanganB != null) widget.soal.pasanganB! : null,
//       if (widget.soal.pasanganC != null) widget.soal.pasanganC! : null,
//       if (widget.soal.pasanganD != null) widget.soal.pasanganD! : null,
//     };

//     emojis = choices.keys.toList();
//     emojis.shuffle(Random(seed));

//     setState(() {
//       _isInitialized = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Scaffold(
//       backgroundColor: LocalColor.transparent,
//       floatingActionButton: (widget.soal.pasanganA != null ||
//               widget.soal.pasanganB != null ||
//               widget.soal.pasanganC != null ||
//               widget.soal.pasanganD != null)
//           ? FloatingActionButton(
//               onPressed: () {
//                 setState(() {
//                   seed = Random().nextInt(100);
//                   emojis.shuffle(Random(seed));
//                   targetSlots = {
//                     if (widget.soal.pasanganA != null) widget.soal.pasanganA! : null,
//                     if (widget.soal.pasanganB != null) widget.soal.pasanganB! : null,
//                     if (widget.soal.pasanganC != null) widget.soal.pasanganC! : null,
//                     if (widget.soal.pasanganD != null) widget.soal.pasanganD! : null,
//                   };
//                 });
//               },
//               child: const Icon(Icons.refresh),
//             )
//           : null,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Wrap(
//               spacing: 20,
//               runSpacing: 20,
//               children: targetSlots.keys.map((nama) {
//                 return DragTarget<String>(  
//                   onAccept: (emoji) {
//                     setState(() {
//                       targetSlots[nama] = emoji;
        
//                       bool semuaTerisi = targetSlots.values.every((v) => v != null);
//                       bool semuaBenar = targetSlots.entries.every((entry) {
//                         final pasangan = entry.key;
//                         final opsi = entry.value;
//                         return opsi != null && choices[opsi] == pasangan;
//                       });
        
//                       if (semuaTerisi && semuaBenar) {
//                         final jawaban = targetSlots.entries
//                             .map((e) => "${e.value}:${e.key}")
//                             .join(",");
//                         widget.onJawabanSelesai?.call(jawaban);
//                       }
//                       print("Cek pasangan: $emoji -> $nama");
//                       print("Semua terisi: $semuaTerisi, Semua benar: $semuaBenar");
//                     });
//                   },
//                   builder: (context, candidateData, rejectedData) {
//                     return Container(
//                       width: 100,
//                       height: 60,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.black, width: 2),
//                         color: targetSlots[nama] != null ? Colors.green[200] : Colors.white,
//                       ),
//                       child: Text(
//                         targetSlots[nama] ?? nama,
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                     );
//                   },
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 40),
//             Wrap(
//               spacing: 20,
//               runSpacing: 20,
//               children: emojis.map((emoji) {
//                 return Draggable<String>(  
//                   data: emoji,
//                   feedback: _buildDraggableItem(emoji, isDragging: true),
//                   childWhenDragging: Opacity(opacity: 0.3, child: _buildDraggableItem(emoji)),
//                   child: targetSlots.containsValue(emoji) ? const SizedBox.shrink() : _buildDraggableItem(emoji),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDraggableItem(String emoji, {bool isDragging = false}) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: isDragging ? Colors.grey[300] : Colors.blueAccent,
//         shape: BoxShape.circle,
//       ),
//       child: Text(
//         emoji,
//         style: const TextStyle(fontSize: 30),
//       ),
//     );
//   }
// }

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
            // const Text(
            //   "Cocokkan Pasangan",
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
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

            // Pasangan (Target) - 2 kolom 2 baris
            // GridView.count(
            //   crossAxisCount: 2,
            //   shrinkWrap: true,
            //   mainAxisSpacing: 16,
            //   crossAxisSpacing: 16,
            //   physics: const NeverScrollableScrollPhysics(),
            //   children: targetSlots.keys.map((nama) {
            //     return DragTarget<String>(
            //       onAccept: (emoji) {
            //         setState(() {
            //           targetSlots[nama] = emoji;

            //           bool semuaTerisi = targetSlots.values.every((v) => v != null);
            //           bool semuaBenar = targetSlots.entries.every((entry) {
            //             final pasangan = entry.key;
            //             final opsi = entry.value;
            //             return opsi != null && choices[opsi] == pasangan;
            //           });

            //           if (semuaTerisi && semuaBenar) {
            //             final jawaban = targetSlots.entries
            //                 .map((e) => "${e.value}:${e.key}")
            //                 .join(",");
            //             widget.onJawabanSelesai?.call(jawaban);
            //           }
            //         });
            //       },
            //       builder: (context, candidateData, rejectedData) {
            //         return Container(
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             border: Border.all(color: Colors.black, width: 2),
            //             color: targetSlots[nama] != null ? Colors.green[200] : Colors.white,
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               targetSlots[nama] ?? nama,
            //               textAlign: TextAlign.center,
            //               style: const TextStyle(fontSize: 16),
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   }).toList(),
            // ),

            // Ganti bagian GridView pasangan
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.5, // lebih lebar dari tinggi
          physics: const NeverScrollableScrollPhysics(),
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

            // Opsi (Draggable) - 2 kolom 2 baris
           // Ganti bagian GridView opsi
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
}
