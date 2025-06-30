import 'package:flutter/material.dart';
import 'package:GamiLearn/models/level.dart';
import 'package:GamiLearn/screen/stageScreen/main/levelScreen.dart';
import 'package:GamiLearn/screen/unknownScreen/widget/noLevelWidget.dart';
import 'package:GamiLearn/services/auth_services.dart';
import 'package:GamiLearn/services/level_progress_service.dart';
import '../../../services/level_services.dart';

class UnitWidget extends StatefulWidget {

  const UnitWidget({super.key});

  @override
  _UnitWidgetState createState() => _UnitWidgetState();
}

class _UnitWidgetState extends State<UnitWidget> {
  late Future<List<Level>> futureLevels;
  List<bool> aksesLevel = [];

  @override
  void initState() {
    super.initState();
    futureLevels =
        LevelService().fetchLevels();
  }

  Future<void> _cekAksesLevel(List<Level> levels) async {
    aksesLevel = List.generate(levels.length, (index) => false);
    final id_user = await AuthService().getUserId();

    for (int i = 0; i < levels.length; i++) {
      if (i == 0) {
        aksesLevel[i] = true; // Level pertama selalu bisa diakses
      } else {
        final result = await LevelProgressService().cekKelulusanLevel(
          id_user: id_user!,
          id_level: levels[i - 1].id_level,
        );
        aksesLevel[i] = result['boleh_lanjut'] == true;
      }
    }
    setState(() {});
  }

  void _navigateToLevel(Level level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelScreen(
          level: level,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = 70;
    double spacing = 80;
    double zigzagOffset = 80;

    return FutureBuilder<List<Level>>(
      future: futureLevels,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: NoLevelWidget());
        }

        List<Level> levels = snapshot.data!;

        if (aksesLevel.length != levels.length) {
          _cekAksesLevel(levels);
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: levels.length * spacing + 50,
                color: Colors.transparent,
              ),
              ...levels.asMap().entries.map((entry) {
                int index = entry.key;
                Level currentLevel = entry.value;

                double topPosition = 20 + (index * spacing);
                double baseOffset = (screenWidth - iconSize) / 2;
                double horizontalOffset = baseOffset +
                    ((index % 2 == 0) ? zigzagOffset : -zigzagOffset);

                bool isAccessible = aksesLevel[index];

                return Positioned(
                  left: horizontalOffset,
                  top: topPosition,
                  child: GestureDetector(
                    onTap: () {
                      if (isAccessible) {
                        _navigateToLevel(currentLevel);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Level ini belum terbuka")),
                        );
                      }
                    },
                    child: Column(
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: isAccessible ? Colors.green : Colors.grey, // Warna bg
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          isAccessible
                              ? "assets/images/component/HiFi-Star on Level Stage.png"
                              : "assets/images/component/HiFi-Lock on Level Stage.png",
                          width: iconSize * 0.5,
                          height: iconSize * 0.5,
                        ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          currentLevel.nama_level,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
