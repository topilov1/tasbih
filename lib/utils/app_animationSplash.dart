import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tasbeh/pages/namozda/app_namoz.dart';

//  one nimatinon page !

class Anomation extends StatelessWidget {
  const Anomation({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          const Image(image: AssetImage('assets/images/splash.png')),
          Text('Bismillah',
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40.sp,
              )),
        ],
      ),
      nextScreen: const MyHomePage(),
      backgroundColor: const Color.fromARGB(255, 96, 44, 40),
      splashIconSize: 500,
      duration: 50,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
