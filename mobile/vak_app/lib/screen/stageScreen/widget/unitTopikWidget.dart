import 'package:GamiLearn/services/score_service.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/models/level.dart';
import 'package:GamiLearn/models/topik.dart';
import 'package:GamiLearn/screen/stageScreen/main/topikScreen.dart';
import 'package:GamiLearn/screen/unknownScreen/widget/noTopicWidget.dart';
import 'package:GamiLearn/services/auth_services.dart';
import 'package:GamiLearn/services/topik_progress_service.dart';
import 'package:GamiLearn/services/topik_service.dart';


class UnitTopikWidget extends StatefulWidget {
  final Level level;

  const UnitTopikWidget({super.key, required this.level});

  @override
  State<UnitTopikWidget> createState() => _UnitTopikWidgetState();
}

class _UnitTopikWidgetState extends State<UnitTopikWidget> {
  late Future<List<Topik>> futureTopiks;
  List<bool> aksesTopik = [];
  List<int> starCounts = [];
  int _currentIndex = 0;
  final SkorService _skorService = SkorService();

  @override
  void initState() {
    super.initState();
    futureTopiks = TopikService().fetchtopiks(widget.level.id_level);
  }

  Future<void> _loadTopicData(List<Topik> topiks) async {
    aksesTopik = List.generate(topiks.length, (index) => false);
    starCounts = List.generate(topiks.length, (index) => 0);
    
    final id_user = await AuthService().getUserId();

    for (int i = 0; i < topiks.length; i++) {
      if (i == 0) {
        aksesTopik[i] = true;
      } else {
        final result = await TopikProgressService().cekKelulusanTopik(
          id_user: id_user!,
          id_topik: topiks[i - 1].id_topik,
        );
        aksesTopik[i] = result['boleh_lanjut'] == true;
      }
      
      try {
        final skorData = await _skorService.fetchJumlahBenarTerbaru(topiks[i].id_topik);
        starCounts[i] = skorData['stars'] ?? 0;
      } catch (e) {
        print('Error fetching stars: $e');
        starCounts[i] = 0;
      }
    }
    
    setState(() {});
  }

  Widget _buildStars(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          Icon(
            i < count ? Icons.star : Icons.star_border,
            color: i < count ? Colors.amber : Colors.grey,
            size: 24,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topik>>(
      future: futureTopiks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: NoTopicWidget());
        }

        List<Topik> topiks = snapshot.data!;

        if (aksesTopik.length != topiks.length || starCounts.length != topiks.length) {
          _loadTopicData(topiks);
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            SizedBox(
              height: 400,
              child: PageView.builder(
                itemCount: topiks.length,
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  final currentTopik = topiks[index];
                  final isAccessible = aksesTopik[index];
                  final starCount = starCounts[index];

                  return GestureDetector(
                    onTap: () {
                      if (isAccessible) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TopikScreen(topik: currentTopik),
                          ),
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.only(
                        right: 16,
                        left: index == 0 ? 16 : 0,
                        top: 8,
                        bottom: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(14)),
                            child: Container(
                              height: 180,
                              color: isAccessible ? Colors.green : Colors.grey,
                              child: Center(
                                child: isAccessible
                                    ? Image.network(  // <-- Ganti Image.asset dengan Image.network untuk URL
                                        currentTopik.icon,
                                        width: 150,
                                        height: 150,
                                        errorBuilder: (context, error, stackTrace) => 
                                            Image.asset("assets/images/placeholder.png"),
                                      )
                                    : Image.asset(
                                        "assets/images/component/HiFi-Lock on Level Stage.png",
                                        width: 150,
                                        height: 150,
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  currentTopik.nama_topik,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                // Bintang ditampilkan di sini (di bawah nama topik)
                                _buildStars(starCount),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isAccessible
                                        ? Colors.green
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                    minimumSize: const Size(double.infinity, 44),
                                  ),
                                  onPressed: () {
                                    if (isAccessible) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TopikScreen(topik: currentTopik),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Mulai Pelajaran",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                topiks.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}