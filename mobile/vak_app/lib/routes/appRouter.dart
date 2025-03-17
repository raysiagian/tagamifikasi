import 'package:flutter/material.dart';
import 'package:vak_app/routes/appRouteConstant.dart';
import 'package:vak_app/screen/auth/loginScreen/main/loginScreen.dart';
import 'package:vak_app/screen/auth/registrationScreen/main/registrationScreen.dart';
import 'package:vak_app/screen/homeScreen/main/homeScreen.dart';
import 'package:vak_app/screen/onboardingScreen/main/onboardingScreen.dart';
import 'package:vak_app/screen/splashScreen/main/splashScreen.dart';
import 'package:vak_app/screen/wrapper/main/wrapperScreen.dart';

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
      //Perbaiki Konstruktor ketika sudah ada logika yg tepat 
      case AppRouteConstant.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      //Perbaiki Konstruktor ketika sudah ada logika yg tepat 
      case AppRouteConstant.wrapperScreen:
        return MaterialPageRoute(builder: (_) => WrapperScreen());

      default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('Error: Route not found')),
        ),
      );
    }
  }
}