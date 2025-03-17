import 'package:flutter/material.dart';
import 'package:vak_app/routes/appRouteConstant.dart';
import 'package:vak_app/style/localColor.dart';
import 'package:vak_app/style/regulerTextStyle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    _buildPage(
                        "assets/images/component/HiFI-Dummy.png",
                        "Bermain Dan Belajar",
                        "Belajar dengan cara yang asik dan menyenangkan"),
                    _buildPage(
                        "assets/images/component/HiFI-Dummy.png",
                        "Metode yang sempurna",
                        "Metode yang tepat buat gaya belajarmu"),
                    _buildPage(
                        "assets/images/component/HiFI-Dummy.png",
                        "Lihat Statistikmu",
                        "Lihatlah bagaimana kamu berkembang"),
                  ],
                ),
              ),
              _buildNavigationButtons(),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: _currentPage < 2
                ? TextButton(
                    onPressed: () => _controller.jumpToPage(2),
                    child: Text(
                      "Lewati",
                      style: TextStyle(color: LocalColor.primary, fontSize: 16),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String imagePath, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: double.infinity, // Agar memenuhi lebar parent
              height: 400,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          if (_currentPage == 2) ...[
            SizedBox(height: 40),
            SizedBox(
              height: 44,
              width: double.infinity,
              child: ElevatedButton(
                // ganti ketika logika loginnya sudah ada
                onPressed: () => Navigator.pushNamed(context, AppRouteConstant.registrationScreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: LocalColor.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                // Ubah text jika sudah memiliki style
                child: Text(
                  "Daftar",
                  style: RegulerTextStyle.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 44,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, AppRouteConstant.loginScreen),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
                child: Text(
                  'Masuk',
                  style: RegulerTextStyle.textTheme.bodyLarge!.copyWith(
                    color: LocalColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage > 0
              ? Container(
                  decoration: BoxDecoration(
                    color: LocalColor.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _prevPage,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                )
              : SizedBox(width: 48), // Memberikan ruang agar posisi tetap rapi
          _currentPage < 2
              ? Container(
                  decoration: BoxDecoration(
                    color: LocalColor.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _nextPage,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              : SizedBox(), // Menghilangkan tombol next di halaman terakhir
        ],
      ),
    );
  }
}
