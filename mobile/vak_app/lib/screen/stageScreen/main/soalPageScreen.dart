import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';

import '../../../services/soal_services.dart';
import 'audioScreen.dart';
import 'kinestetikScreen.dart';
import 'visualScreen.dart';
// import 'package:vak_app/services/soal_service.dart';
// import 'package:vak_app/screens/audio_screen.dart';
// import 'package:vak_app/screens/visual_screen.dart';
// import 'package:vak_app/screens/kinestetik_screen.dart';

class SoalPage extends StatefulWidget {
  final int idMataPelajaran;
  final int idLevel;

  SoalPage({Key? key, required this.idMataPelajaran, required this.idLevel})
      : super(key: key);

  @override
  _SoalPageState createState() => _SoalPageState();
}

class _SoalPageState extends State<SoalPage> {
  late Future<SoalResponse> soalResponse;

  @override
  void initState() {
    super.initState();
    soalResponse = SoalService().fetchSoal(widget.idMataPelajaran, widget.idLevel);
  }

  void _navigateToSoal(Soal soal) {
    Widget screen;
    switch (soal.tipeSoal) {
      case "auditory":
        screen = AudioScreen(soal: soal);
        break;
      case "visual":
        screen = VisualScreen(soal: soal);
        break;
      case "kinesthetic":
        screen = KinestetikScreen(soal: soal);
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Soal")),
      body: FutureBuilder<SoalResponse>(
        future: soalResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.soal.isEmpty) {
            return Center(child: Text("Tidak ada soal untuk level ini"));
          } else {
            List<Soal> soal = snapshot.data!.soal; // Mengambil soal dari SoalResponse
            return ListView.builder(
              itemCount: soal.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(soal[index].pertanyaan),
                  onTap: () {
                    _navigateToSoal(soal[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
