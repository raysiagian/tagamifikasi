import 'package:flutter/material.dart';
import 'package:GamiLearn/models/level.dart';
import 'package:GamiLearn/routes/appRouteConstant.dart';
import 'package:GamiLearn/screen/auth/forgetPasswordScreen/main/forgetPasswordScreen.dart';
import 'package:GamiLearn/screen/auth/loginScreen/main/loginScreen.dart';
import 'package:GamiLearn/screen/auth/registrationScreen/main/registrationScreen.dart';
import 'package:GamiLearn/screen/homeScreen/main/homeScreen.dart';
import 'package:GamiLearn/screen/onboardingScreen/main/onboardingScreen.dart';
import 'package:GamiLearn/screen/splashScreen/main/splashScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/afterLevelScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/kinestetikScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/levelScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/stageScreen.dart';
import 'package:GamiLearn/screen/statisticScreen/main/statisticPage.dart';
import 'package:GamiLearn/screen/wrapper/main/wrapperScreen.dart';
import 'package:GamiLearn/models/topik.dart';

class AppRouter{
static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteConstant.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRouteConstant.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppRouteConstant.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRouteConstant.registrationScreen:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case AppRouteConstant.forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());
      case AppRouteConstant.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRouteConstant.wrapperScreen:
        return MaterialPageRoute(builder: (_) => WrapperScreen());
      // case AppRouteConstant.afterLevelScreen:
      //   return MaterialPageRoute(builder: (_) => AfterLevelScreen());
      // case AppRouteConstant.afterLevelScreen:
      //   if (settings.arguments is int) {
      //     final idMataPelajaran = settings.arguments as int;
      //     return MaterialPageRoute(
      //       builder: (_) => AfterLevelScreen(idMataPelajaran: idMataPelajaran, idLevel: idLevel,),
      //     );
      //   }

      // case AppRouteConstant.afterLevelScreen:
      //   if (settings.arguments is Map<String, dynamic>) {
      //     final args = settings.arguments as Map<String, dynamic>;
      //     final int idMataPelajaran = args['idMataPelajaran'];
      //     final int idLevel = args['idLevel'];
          
      //     return MaterialPageRoute(
      //       builder: (_) => AfterLevelScreen(
      //         topik : id_
      //       ),
      //     );
      //   }

      //   return MaterialPageRoute(
      //     builder: (_) => Scaffold(
      //       body: Center(child: Text('Error: Argument tidak lengkap untuk AfterLevelScreen')),
      //     ),
      //   );

      // case AppRouteConstant.afterLevelScreen:
      //   if (settings.arguments is Map<String, dynamic>) {
      //     final args = settings.arguments as Map<String, dynamic>;
      //     final Topik topik = args['topik']; // Assuming you're passing a Topik object
          
      //     return MaterialPageRoute(
      //       builder: (_) => AfterLevelScreen(
      //         topik: topik,
      //       ),
      //     );
      //   }

      //   return MaterialPageRoute(
      //     builder: (_) => Scaffold(
      //       body: Center(child: Text('Error: Argument tidak lengkap untuk AfterLevelScreen')),
      //     ),
      //   );

      case AppRouteConstant.statisticScreen:
        return MaterialPageRoute(builder: (_) =>StatisticScreen());
      case AppRouteConstant.stageScreen:
        if (settings.arguments is int) {
          final idMataPelajaran = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => StageScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body:
                Center(child: Text('Error: ID Mata Pelajaran tidak ditemukan')),
          ),
        );

      case AppRouteConstant.levelScreen:
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => LevelScreen(
              level: args['level'],
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text(
                    'Error: Data Level atau ID Mata Pelajaran tidak ditemukan')),
          ),
        );
      default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('Error: Route not found')),
        ),
      );
    }
  }
}  