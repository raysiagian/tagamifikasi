import 'package:flutter/material.dart';
import 'package:vak_app/models/mataPelajaran.dart';
import 'package:vak_app/screen/statisticScreen/main/detailStatisticPage.dart';
import 'package:vak_app/services/matapelajaran_services.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class SubjectList extends StatefulWidget {
  const SubjectList({super.key});

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  late Future<List<MataPelajaran>> _mataPelajaranFuture;

  @override
  void initState() {
    super.initState();
    _mataPelajaranFuture = MataPelajaranService().fetchMataPelajaran();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MataPelajaran>>(
      future: _mataPelajaranFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Data tidak tersedia"));
        }

        List<MataPelajaran> mataPelajaranList = snapshot.data!;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: mataPelajaranList.map((mataPelajaran) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailStatisticPage(
                            mataPelajaran: mataPelajaran,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: LocalColor.primary, width: 2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(mataPelajaran.iconPath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              mataPelajaran.nama,
                              style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                                color: LocalColor.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
