import 'package:flutter/material.dart';
import 'package:vak_app/screen/statisticScreen/widget/levelListWidget.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class StatisticDetailPage extends StatefulWidget {
  const StatisticDetailPage({super.key});

  @override
  State<StatisticDetailPage> createState() => _StatisticDetailPageState();
}

class _StatisticDetailPageState extends State<StatisticDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mata Pelajaran") ,
        ),
         body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background/HiFi-Statistic Background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            // padding: EdgeInsets.symmetric(horizontal: screenWidth*0.08),
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 79,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: LocalColor.yellowBackground,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 20,
                      child: Container(
                        width: 80,
                        height: 60,
                        decoration:BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/component/HiFi-Statistic Book Image.png'),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                    ),
                    Positioned(
                    left: 14,
                    top: 25,
                    child: SizedBox(
                      width: 146,
                      child: Text(
                      'Mata Pelajaran',
                        style: BoldTextStyle.textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                LevelListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}