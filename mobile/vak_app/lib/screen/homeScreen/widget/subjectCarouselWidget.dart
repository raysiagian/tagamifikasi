import 'package:flutter/material.dart';
import 'package:GamiLearn/routes/appRouteConstant.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:GamiLearn/style/regulerTextStyle.dart';

class SubjectCarouselWidget extends StatelessWidget {
  final bool isActive;
  final int idMataPelajaran; // Tambahkan idMataPelajaran

  const SubjectCarouselWidget({
    super.key,
    required this.isActive,
    required this.idMataPelajaran, // Wajib diisi saat memanggil widget ini
  });

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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: isActive ? 294 : 240, // Ukuran dinamis
              height: isActive ? 299 : 220, // Ukuran dinamis
              child: FittedBox(
                fit: BoxFit.cover,
                child:
                    Image.asset("assets/images/background/homebackground.png"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Materi",
            style: BoldTextStyle.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: IntrinsicWidth(
              child: Container(
                height: isActive
                    ? 44
                    : 36, // Sesuaikan tinggi dengan keadaan aktif/tidak
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LocalColor.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouteConstant.stageScreen,
                      arguments: idMataPelajaran, // Kirim ID dari API
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