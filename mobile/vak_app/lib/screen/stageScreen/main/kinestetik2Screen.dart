import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';
import 'dart:math';

import 'package:vak_app/style/localColor.dart';

class Kinestetik2Screen extends StatefulWidget {
  final Soal soal;
  final Function(String)? onJawabanSelesai;

  Kinestetik2Screen({Key? key, required this.soal,this.onJawabanSelesai}) : super(key: key);

  @override
  State<Kinestetik2Screen> createState() => _Kinestetik2ScreenState();
}

class _Kinestetik2ScreenState extends State<Kinestetik2Screen> {
  late List<String?> answerSlots;
  late List<String> shuffledLetters;

  @override
  void initState() {
    super.initState();
    answerSlots = List.filled(widget.soal.pertanyaan!.length,null);
    shuffledLetters = widget.soal.pertanyaan!.split('')..shuffle(Random());
  }

  void _onLetterDropped(String letter, int index) {
  setState(() {
    if (answerSlots[index] == null) {
      answerSlots[index] = letter;
      shuffledLetters.remove(letter);
       _updateJawaban();
      // Cek jika semua huruf sudah diisi
      if (!answerSlots.contains(null)) {
        String jawaban = answerSlots.join();
        print("ID Soal:  ,Jawaban pengguna: $jawaban");
        if (widget.onJawabanSelesai != null) {
          widget.onJawabanSelesai!(jawaban);
        }
      }
    }
  });
}


  
  void _removeLetterFromSlot(int index) {
    setState(() {
      if (answerSlots[index] != null) {
        shuffledLetters.add(answerSlots[index]!);
        answerSlots[index] = null;
        _updateJawaban();
      }
    });
  }

    void _updateJawaban() {
    String jawaban = answerSlots.whereType<String>().join();
    if (widget.onJawabanSelesai != null) {
      widget.onJawabanSelesai!(jawaban);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool onJawabanSelesai = !answerSlots.contains(null);
    // final bool isCorrect = answerSlots.join() == widget.soal.pertanyaan;

    return Scaffold(
      backgroundColor: LocalColor.transparent,
      body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(widget.soal.media ??
                      "https://res.cloudinary.com/dio9zvrg3/image/upload/v1744163521/soal/media/ptcadvfrwpmpuza3uky4.png"), // Fallback gambar
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Urutkan Kata"),
            const SizedBox(height: 24),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(answerSlots.length, (index) {
                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return GestureDetector(
                        onTap: () => _removeLetterFromSlot(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            answerSlots[index] ?? '',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    onAccept: (letter) => _onLetterDropped(letter, index),
                    onWillAccept: (data) => answerSlots[index] == null,
                  );
                }),
              ),
               const SizedBox(height: 40),
        
              // HURUF YANG BISA DIPILIH
              Wrap(
                spacing: 10,
                children: shuffledLetters.map((letter) {
                  return Draggable<String>(
                    data: letter,
                    feedback: Material(
                      child: Container(
                        width: 40,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(letter, style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: _buildLetterTile(letter),
                    ),
                    child: _buildLetterTile(letter),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              // if (onJawabanSelesai)
              //   Text(
              //     isCorrect ? 'Jawaban Benar!' : 'Coba lagi!',
              //     style: TextStyle(
              //       fontSize: 20,
              //       color: isCorrect ? Colors.green : Colors.red,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
                const SizedBox(height: 40,),
                  
          ],
        ),
      ),
    );
    
  }
} 


  Widget _buildLetterTile(String letter) {
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(letter, style: TextStyle(fontSize: 24)),
    );
  }