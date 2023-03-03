import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/pages/home_page/home_page.dart';
import 'package:page_transition/page_transition.dart';

class AnimatedScreen extends StatelessWidget {
  const AnimatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return AnimatedSplashScreen(
      curve: Curves.bounceIn,
      pageTransitionType: PageTransitionType.fade,
      splashIconSize: 900,
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      backgroundColor: Colors.blue,
      splash: Container(
        decoration:  BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              model.setBg(),
            ),
          ),
        ),
      ),
      disableNavigation: false,
      nextScreen: HomePage(),
    );
  }
}
