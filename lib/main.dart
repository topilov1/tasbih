import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasbeh/data/data.page.dart';
import 'package:tasbeh/pages/app_Zikirs.dart';
import 'package:tasbeh/utils/app_animationSplash.dart';
import 'package:tasbeh/pages/namozda/app_namoz.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            MyHomePage.id: (context) => const MyHomePage(),
            Zikirs.id: (context) => Zikirs(infoZikir: zikirlar.join()),
          },
          home: const Anomation(),
        );
      },
    );
  }
}
