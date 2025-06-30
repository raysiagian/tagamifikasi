import 'package:GamiLearn/screen/profileScreen/main/premiumPaymentScreen.dart';
import 'package:GamiLearn/services/rank_services.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/models/users.dart';
import 'package:GamiLearn/services/auth_services.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Users?> userFuture;
  late Future<Map<String, dynamic>> rankFuture; // Future untuk data rank

  @override
  void initState() {
    super.initState();
    userFuture = AuthService().getUser();
    rankFuture = RankService().fetchRank(); // Ambil data rank
  }

  String _getRankImagePath(String namaRank) {
    switch (namaRank.toLowerCase()) {
      case 'perunggu':
        return "assets/images/rank/rank-bronze.png";
      case 'perak':
        return "assets/images/rank/rank-silver.png";
      case 'emas':
        return "assets/images/rank/rank-gold.png";
      default:
        return "assets/images/rank/rank-bronze.png"; // Default
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Users?>(
          future: userFuture,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (userSnapshot.hasError) {
              return Center(child: Text('Error: ${userSnapshot.error}'));
            } else if (!userSnapshot.hasData || userSnapshot.data == null) {
              return Center(child: Text('User data not available'));
            }

            Users user = userSnapshot.data!;
            String imagePath;
              
            if (user.gender.toLowerCase() == 'laki-laki') {
              imagePath = "assets/images/component/dummy male.png";
            } else if (user.gender.toLowerCase() == 'perempuan') {
              imagePath = "assets/images/component/dummy female.png";
            } else {
              imagePath = "assets/images/component/dummy male.png";
            }

            return FutureBuilder<Map<String, dynamic>>(
              future: rankFuture,
              builder: (context, rankSnapshot) {
                if (rankSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (rankSnapshot.hasError) {
                  return Center(child: Text('Error loading rank: ${rankSnapshot.error}'));
                }

                // Default values jika rank tidak tersedia
                String namaRank = 'Perunggu';
                String rankImagePath = _getRankImagePath(namaRank);

                if (rankSnapshot.hasData) {
                  namaRank = rankSnapshot.data!['nama_rank'] ?? 'Perunggu';
                  rankImagePath = _getRankImagePath(namaRank);
                }

                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background/HiFi-Profile Background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      children: [
                        Container(
                          height: 79,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: LocalColor.yellowBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25, left: 14),
                            child: Text(
                              'Profil',
                              style: BoldTextStyle.textTheme.titleMedium!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        imagePath,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Image.asset(
                                        rankImagePath,
                                        width: 50, // Sesuaikan ukuran
                                        height: 50,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(user.name, style: BoldTextStyle.textTheme.titleMedium),
                                Text(user.username),
                                Text("Gender: ${user.gender}"),
                                Text("Tanggal Lahir: ${user.tanggalLahir}"),
                                Text("Rank: $namaRank"), // Tampilkan nama rank
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 44,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: LocalColor.redBackground,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                    ),
                                    child: Text(
                                      "Keluar",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}