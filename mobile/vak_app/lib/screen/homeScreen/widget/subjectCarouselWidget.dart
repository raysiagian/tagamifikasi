import 'package:flutter/material.dart';
import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';
import 'package:vak_app/style/regulerTextStyle.dart';

class SubjectCarouselWidget extends StatelessWidget {
  final bool isActive;

  const SubjectCarouselWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 320 : 280, // Kurangi ukuran saat tidak aktif
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gunakan ClipRRect untuk mencegah overflow
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: isActive ? 294 : 240, // Ukuran dinamis
              height: isActive ? 299 : 220, // Ukuran dinamis
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset("assets/images/background/homebackground.png"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Materi",
            style: BoldTextStyle.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // **🔹 Gunakan AnimatedSize agar tombol berubah ukuran secara smooth**
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: IntrinsicWidth(
              child: Container(
                height: isActive ? 44 : 36, // Sesuaikan tinggi dengan keadaan aktif/tidak
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LocalColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StageScreen()),
                    );
                  },
                  child: Text(
                    "Mulai Pelajaran",
                    style: RegulerTextStyle.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontSize: isActive ? 16 : 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
