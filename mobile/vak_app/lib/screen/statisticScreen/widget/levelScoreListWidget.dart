import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/services/score_service.dart';
import 'package:GamiLearn/style/localColor.dart';

class LevelScoreList extends StatefulWidget {
  const LevelScoreList({super.key});

  @override
  State<LevelScoreList> createState() => _LevelScoreListState();
}

class _LevelScoreListState extends State<LevelScoreList> {
  late Future<List<dynamic>> _levelScores;
  final SkorService _skorService = SkorService();

  @override
  void initState() {
    super.initState();
    _levelScores = _skorService.fetchAllLevelScores();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: FutureBuilder<List<dynamic>>(
          future: _levelScores,
          builder: (context, snapshot) {
            // Handle loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Handle error state
            if (snapshot.hasError) {
              return Text("Terjadi kesalahan: ${snapshot.error}");
            }

            // Handle empty or null data
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("Belum ada skor yang tersedia.");
            }

            // Process and display scores
            return Column(
              children: snapshot.data!.map((score) {
                final jumlahBintang = score['jumlah_bintang'] as int;
                final levelName = score['penjelasan_level'] ?? 
                                score['level']?['penjelasan_level'] ?? 
                                'Level ${score['id_level']}';

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: LocalColor.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(levelName),
                        Row(
                          children: List.generate(
                            3,
                            (i) => Icon(
                              i < jumlahBintang
                                  ? CupertinoIcons.star_fill
                                  : CupertinoIcons.star,
                              color: Colors.amber,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}