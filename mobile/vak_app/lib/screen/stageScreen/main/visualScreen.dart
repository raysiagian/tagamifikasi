import 'package:flutter/material.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';
class VisualScreen extends StatefulWidget {
  @override
  State<VisualScreen> createState() => _VisualScreenState();
}

class _VisualScreenState extends State<VisualScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(title: Text("Pertanyaan")),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // ganti dengan data api
              image: DecorationImage(
                image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            width: double.infinity,
            height: 102,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: LocalColor.primary, width: 1),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 29),
              child: Row(
                children: [
                 ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LocalColor.primary, // Warna latar tombol
                      minimumSize: Size(40, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Sudut tombol persegi
                      ),
                      padding: EdgeInsets.all(16), // Beri padding agar gambar tidak terlalu besar
                    ),
                    onPressed: () {
                      print("Button ditekan!");
                    },
                    child: Image.asset(
                      "assets/images/component/HiFi-Speaker.png", // Ganti dengan path gambarmu
                      width: 40, // Ukuran gambar
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 21),
                  Expanded( // 🔹 Membuat teks bisa turun ke bawah jika melebihi lebar
                    child: Text(
                      "Hewan apa kah yang ada pada gambar",
                      style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                        color: LocalColor.primary,
                      ),
                      softWrap: true, // 🔹 Memastikan teks bisa pindah baris
                      overflow: TextOverflow.visible, // 🔹 Mencegah teks terpotong
                    ),
                  ),
                ],
              ),
            ),
          ),
           SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildAnswerButton(context, "A. Burung Hantu", true),
                _buildAnswerButton(context, "B. Kucing", false),
                _buildAnswerButton(context, "C. Kambing", false),
                _buildAnswerButton(context, "D. Sapi", false),
              ],
            ),
        ],
      ),
    ),
    );
  }
}

 Widget _buildAnswerButton(BuildContext context, String text, bool isCorrect) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isCorrect ? "Jawaban Benar! 🎉" : "Jawaban Salah, coba lagi! ❌"),
              duration: Duration(seconds: 1),
              backgroundColor: isCorrect ? Colors.green : Colors.red,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: LocalColor.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

