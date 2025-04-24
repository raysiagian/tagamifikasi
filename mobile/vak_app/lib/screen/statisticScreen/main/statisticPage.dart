import 'package:flutter/material.dart';
import 'package:GamiLearn/screen/statisticScreen/widget/subjectListWidget.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:GamiLearn/style/regulerTextStyle.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                      'Statistik Saya',
                        style: BoldTextStyle.textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                SubjectList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}