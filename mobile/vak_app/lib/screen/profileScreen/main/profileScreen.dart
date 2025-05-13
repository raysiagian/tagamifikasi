import 'package:GamiLearn/screen/profileScreen/main/premiumPaymentScreen.dart';
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

  @override
  void initState() {
    super.initState();
    userFuture = AuthService().getUser();  // Fetch user data on init
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Users?>(
          future: userFuture,
          builder: (context, snapshot) {
            // Check the snapshot status
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());  // Loading state
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('User data not available'));
            }

            // Now we know that the user is not null and data is available
            Users user = snapshot.data!;
            String imagePath;
              
            // Gender check for image path
            if (user.gender.toLowerCase() == 'laki-laki') {
              imagePath = "assets/images/component/dummy male.png";
            } else if (user.gender.toLowerCase() == 'perempuan') {
              imagePath = "assets/images/component/dummy female.png";
            } else {
              imagePath = "assets/images/component/dummy male.png"; // Default
              print("Image path: $imagePath");
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
                            ClipOval(
                              child: Image.asset(
                                imagePath,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(user.name, style: BoldTextStyle.textTheme.titleMedium),
                            Text(user.username),
                            Text("Gender: ${user.gender}"),
                            Text("Tanggal Lahir: ${user.tanggalLahir}"),
                            const SizedBox(height: 40),

                            // Pembayaran Tekno
                            const SizedBox(height: 40),
                            SizedBox(
                              height: 44,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=> PaymentScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: LocalColor.greenBackground,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                child: Text(
                                  "Coba Premium",
                                  style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // 
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
                                  style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
        ),
      ),
    );
  }
}