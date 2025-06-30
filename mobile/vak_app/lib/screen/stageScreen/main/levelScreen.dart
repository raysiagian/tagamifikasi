import 'package:GamiLearn/routes/appRouteConstant.dart';
import 'package:GamiLearn/screen/stageScreen/widget/unitTopikWidget.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/models/level.dart';
import 'package:GamiLearn/models/soal.dart';
import 'package:GamiLearn/screen/stageScreen/main/afterLevelScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/audio2Screen.dart';
import 'package:GamiLearn/screen/stageScreen/main/audioScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/kinestetik2Screen.dart';
import 'package:GamiLearn/screen/stageScreen/main/kinestetikScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/visual2Screen.dart';
import 'package:GamiLearn/screen/stageScreen/main/visualScreen.dart';
import 'package:GamiLearn/screen/unknownScreen/widget/customErrorWidget.dart';
import 'package:GamiLearn/screen/unknownScreen/widget/noQuestionWidget.dart';
import 'package:GamiLearn/services/auth_services.dart';
import 'package:GamiLearn/services/jawaban_services.dart';
import 'package:GamiLearn/services/soal_services.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelScreen extends StatefulWidget {
  final Level level;

  const LevelScreen({super.key, required this.level,});

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.level.nama_level),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, AppRouteConstant.wrapperScreen);
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/background/HiFi-Stage Background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                child: UnitTopikWidget(level: widget.level),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
