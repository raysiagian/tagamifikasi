// import 'package:GamiLearn/models/mataPelajaran.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:GamiLearn/style/localColor.dart';

// // class LevelScoreList extends StatefulWidget {
// //   const LevelScoreList({super.key});

// //   @override
// //   State<LevelScoreList> createState() => _LevelScoreListState();
// // }

// class LevelScoreList extends StatefulWidget {
//   final MataPelajaran mataPelajaran;

//   const LevelScoreList({super.key, required this.mataPelajaran});

//   @override
//   State<LevelScoreList> createState() => _LevelScoreListState();
// }


// class _LevelScoreListState extends State<LevelScoreList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         child: Column(
//           // ganti ketika sudah memiliki data
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: LocalColor.primary, width: 2),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: Row(
//                   children: [
//                     Text("Nama Level"),
//                     const SizedBox(width: 40),
//                     Container(
//                       child: Row(
//                         children: [
//                           Icon(
//                             CupertinoIcons.star,
//                             color: Colors.amber,
//                             size: 30.0,
//                           ),
//                            Icon(
//                             CupertinoIcons.star,
//                             color: Colors.amber,
//                             size: 30.0,
//                           ),
//                            Icon(
//                             CupertinoIcons.star,
//                             color: Colors.amber,
//                             size: 30.0,
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:GamiLearn/services/score_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/models/mataPelajaran.dart';
import 'package:GamiLearn/style/localColor.dart';


class LevelScoreList extends StatefulWidget {
  final MataPelajaran mataPelajaran;

  const LevelScoreList({super.key, required this.mataPelajaran});

  @override
  State<LevelScoreList> createState() => _LevelScoreListState();
}

class _LevelScoreListState extends State<LevelScoreList> {
  late Future<List<dynamic>> _levelScores;
  final SkorService _skorService = SkorService(); // Panggil dari service

  @override
  void initState() {
    super.initState();
    _levelScores = _skorService.fetchLevelScores(widget.mataPelajaran.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: FutureBuilder<List<dynamic>>(
          future: _levelScores,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Terjadi kesalahan: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("Belum ada skor yang tersedia.");
            }

            return Column(
              children: snapshot.data!.asMap().map((index, skor) {
                final totalSkor = skor['total_skor'] as int;
                final levelName = 'Level ${index + 1}'; // Nama level dibuat berdasarkan urutan list

                return MapEntry(
                  index,
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      border: const Border(
                        bottom: BorderSide(color: LocalColor.primary, width: 1.5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(levelName), // Menampilkan "Level 1", "Level 2", dll
                          Row(
                            children: List.generate(
                              3,
                              (i) => Icon(
                                i < (totalSkor / 10).clamp(0, 3).round()
                                    ? CupertinoIcons.star_fill
                                    : CupertinoIcons.star,
                                color: Colors.amber,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).values.toList(),
            );

          },
        ),
      ),
    );
  }
}
