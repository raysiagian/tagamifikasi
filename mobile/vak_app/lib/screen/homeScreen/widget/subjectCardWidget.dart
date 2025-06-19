import 'package:flutter/material.dart';
import 'package:GamiLearn/screen/stageScreen/main/stageScreen.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:GamiLearn/style/regulerTextStyle.dart';

class SubjectCardWidget extends StatelessWidget {
  final int idMataPelajaran;
  const SubjectCardWidget({super.key,  required this.idMataPelajaran});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.only(
        top: 16,
        left: 14,
        right: 14,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 157,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Materi",
            style: BoldTextStyle.textTheme.titleLarge!.copyWith(
              color: LocalColor.primary,
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: LocalColor.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StageScreen(),
                ),
              );
            },
            child: Text(
              "Mulai Pelajaran",
              style: RegulerTextStyle.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
