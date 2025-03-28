// import 'package:flutter/material.dart';
// import 'package:vak_app/models/level.dart';
// import 'package:vak_app/models/soal.dart';
// import 'package:vak_app/screen/stageScreen/main/audioScreen.dart';
// import 'package:vak_app/screen/stageScreen/main/kinestetikScreen.dart';
// import 'package:vak_app/screen/stageScreen/main/visualScreen.dart';

// class LevelScreen extends StatefulWidget {
//   final Level level; // Terima Level sebagai parameter

//   const LevelScreen({Key? key, required this.level}) : super(key: key);

//   @override
//   _LevelScreenState createState() => _LevelScreenState();
// }

// class _LevelScreenState extends State<LevelScreen> {
//   late Future<List<Soal>> futureSoal;

//   @override
//   void initState() {
//     super.initState();
//     futureSoal = fetchSoalByLevel(widget.level.id_level);
//   }

//   Future<List<Soal>> fetchSoalByLevel(int idLevel) async {
//     await Future.delayed(Duration(seconds: 1)); // Simulasi loading
//     return soalList.where((soal) => soal.id_level == idLevel).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Level ${widget.level.id_level} - ${widget.level.penjelasan_level}")),
//       body: FutureBuilder<List<Soal>>(
//         future: futureSoal,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("Tidak ada soal untuk level ini"));
//           }

//           final soalList = snapshot.data!;

//           return ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: soalList.length,
//             itemBuilder: (context, index) {
//               final soal = soalList[index];

//               return Card(
//                 child: ListTile(
//                   leading: soal.media != null
//                       ? Image.asset('assets/${soal.media}', width: 50, height: 50, fit: BoxFit.cover)
//                       : Icon(Icons.question_mark),
//                   title: Text(soal.pertanyaan ?? "Pertanyaan tidak tersedia"),
//                   subtitle: soal.audioPertanyaan != null ? Text("Audio: ${soal.audioPertanyaan}") : null,
//                   onTap: () => _navigateToScreen(context, soal),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _navigateToScreen(BuildContext context, Soal soal) {
//     Widget screen;
//     switch (soal.tipeSoal.toLowerCase()) {
//       case 'kinestetik':
//         screen = KinestetikScreen(soal: soal);
//         break;
//       case 'auditory':
//         screen = AudioScreen(soal: soal);
//         break;
//       case 'visual':
//         screen = VisualScreen(soal: soal);
//         break;
//       default:
//         screen = Scaffold(
//           appBar: AppBar(title: Text("Error")),
//           body: Center(child: Text("Tipe soal tidak dikenali")),
//         );
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => screen),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:vak_app/models/level.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/screen/stageScreen/main/audioScreen.dart';
import 'package:vak_app/screen/stageScreen/main/kinestetikScreen.dart';
import 'package:vak_app/screen/stageScreen/main/visualScreen.dart';
import 'package:vak_app/style/localColor.dart';

class LevelScreen extends StatefulWidget {
  final Level level;

  const LevelScreen({Key? key, required this.level}) : super(key: key);

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late Future<List<Soal>> futureSoal;
  int _currentIndex = 0;
  List<Soal> _soalList = [];

  @override
  void initState() {
    super.initState();
    futureSoal = fetchSoalByLevel(widget.level.id_level);
  }

  Future<List<Soal>> fetchSoalByLevel(int idLevel) async {
    await Future.delayed(Duration(seconds: 1)); // Simulasi loading
    return soalList.where((soal) => soal.id_level == idLevel).toList();
  }

  void _nextQuestion() {
    if (_currentIndex < _soalList.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Jika soal terakhir, bisa tampilkan skor atau tombol kembali
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Soal selesai!"))
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Level ${widget.level.id_level} - ${widget.level.penjelasan_level}")),
    body: FutureBuilder<List<Soal>>(
      future: futureSoal,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Tidak ada soal untuk level ini"));
        }

        _soalList = snapshot.data!;
        final soal = _soalList[_currentIndex];

        // Tentukan warna background berdasarkan tipe soal
        Color backgroundColor;
        switch (soal.tipeSoal.toLowerCase()) {
          case 'visual':
            backgroundColor = LocalColor.redBackground; // Atau Colors.red
            break;
          case 'auditory':
            backgroundColor = LocalColor.greenBackground; // Contoh warna lain
            break;
          case 'kinestetik':
            backgroundColor = LocalColor.yellowBackground; // Contoh warna lain
            break;
          default:
            backgroundColor = Colors.white;
        }

        return Container(
          color: backgroundColor, // Terapkan warna background
          child: Column(
            children: [
              Expanded(child: _buildSoalScreen(soal)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  child: Text("Selanjutnya"),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Level ${widget.level.id_level} - ${widget.level.penjelasan_level}")),
//       body: FutureBuilder<List<Soal>>(
//         future: futureSoal,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("Tidak ada soal untuk level ini"));
//           }

//           _soalList = snapshot.data!;
//           final soal = _soalList[_currentIndex];

//           return Column(
//             children: [
//               Expanded(child: _buildSoalScreen(soal)),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: _nextQuestion,
//                   child: Text("Selanjutnya"),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

  Widget _buildSoalScreen(Soal soal) {
    switch (soal.tipeSoal.toLowerCase()) {
      case 'kinestetik':
        return KinestetikScreen(soal: soal);
      case 'auditory':
        return AudioScreen(soal: soal);
      case 'visual':
        return VisualScreen(soal: soal);
      default:
        return Center(child: Text("Tipe soal tidak dikenali"));
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:vak_app/models/level.dart';
// import 'package:vak_app/models/soal.dart';
 
// import 'package:vak_app/screen/stageScreen/main/audioScreen.dart';
// import 'package:vak_app/screen/stageScreen/main/kinestetikScreen.dart';
// import 'package:vak_app/screen/stageScreen/main/visualScreen.dart';

// import '../../../services/levelServices.dart';

// class LevelScreen extends StatefulWidget {
//   final int idMataPelajaran; // ✅ Parameter ID mata pelajaran

//   const LevelScreen({Key? key, required this.idMataPelajaran}) : super(key: key);

//   @override
//   _LevelScreenState createState() => _LevelScreenState();
// }

// class _LevelScreenState extends State<LevelScreen> {
//   late Future<Level> futureLevel;
//   late Future<List<Soal>> futureSoal;
//   int _currentIndex = 0;
//   List<Soal> _soalList = [];

//   @override
//   void initState() {
//     super.initState();
//     futureLevel = LevelService().fetchLevelsByMataPelajaran(widget.idMataPelajaran).then((levels) {
//       if (levels.isNotEmpty) {
//         return levels.first; // ✅ Ambil level pertama untuk contoh
//       } else {
//         throw Exception("Tidak ada level untuk mata pelajaran ini");
//       }
//     });

//     // futureSoal = futureLevel.then((level) => SoalService().fetchSoalByLevel(level.idLevel));
//   }

//   void _nextQuestion() {
//     if (_currentIndex < _soalList.length - 1) {
//       setState(() {
//         _currentIndex++;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Soal selesai!"))
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Level")),
//       body: FutureBuilder<Level>(
//         future: futureLevel,
//         builder: (context, levelSnapshot) {
//           if (levelSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (levelSnapshot.hasError) {
//             return Center(child: Text("Error: ${levelSnapshot.error}"));
//           } else if (!levelSnapshot.hasData) {
//             return Center(child: Text("Tidak ada level yang ditemukan."));
//           }

//           final level = levelSnapshot.data!;
//           return FutureBuilder<List<Soal>>(
//             future: futureSoal,
//             builder: (context, soalSnapshot) {
//               if (soalSnapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (soalSnapshot.hasError) {
//                 return Center(child: Text("Error: ${soalSnapshot.error}"));
//               } else if (!soalSnapshot.hasData || soalSnapshot.data!.isEmpty) {
//                 return Center(child: Text("Tidak ada soal untuk level ini."));
//               }

//               _soalList = soalSnapshot.data!;
//               final soal = _soalList[_currentIndex];

//               return Column(
//                 children: [
//                   Expanded(child: _buildSoalScreen(soal)),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: ElevatedButton(
//                       onPressed: _nextQuestion,
//                       child: Text("Selanjutnya"),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSoalScreen(Soal soal) {
//     switch (soal.tipeSoal.toLowerCase()) {
//       case 'kinestetik':
//         return KinestetikScreen(soal: soal);
//       case 'auditory':
//         return AudioScreen(soal: soal);
//       case 'visual':
//         return VisualScreen(soal: soal);
//       default:
//         return Center(child: Text("Tipe soal tidak dikenali"));
//     }
//   }
// }
