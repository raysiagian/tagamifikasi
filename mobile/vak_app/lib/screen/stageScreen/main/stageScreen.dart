import 'package:flutter/material.dart';
import 'package:GamiLearn/routes/appRouteConstant.dart';
import 'package:GamiLearn/screen/stageScreen/widget/unitWidget.dart';

class StageScreen extends StatefulWidget {
  const StageScreen({super.key});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: const Text("Bermain")),
        // appBar: AppBar(
        //   title: const Text("Bermain"),
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pushNamed(context, AppRouteConstant.wrapperScreen);
        //     },
        //   ),
        // ),
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
                child: UnitWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
