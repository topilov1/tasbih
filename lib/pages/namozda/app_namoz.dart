import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasbeh/utils/app_drawer.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';

class MyHomePage extends StatefulWidget {
  static const id = 'home';
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter3 = 0;
  bool vibrateTap = true;
  var box;

//namozdagi zikirlar controllor;
  bool is33 = true;
  List<String> zikirList = [
    'Subhanalloh',
    'Alhamdulillah',
    'Allohu Akbar',
  ];

// all save hive
  @override
  void initState() {
    box = Hive.box('db');
    counter3 = box.get('tasbehSoni') ?? 0;
    super.initState();
  }

// vibrate icon controllor
  void vibrate() {
    vibrateTap = !vibrateTap;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    counter3;
  }

// controllor
  void controller2() {
    if (vibrateTap == false) {
      Vibrate.feedback(FeedbackType.heavy);
    }
    counter3++;
    print(counter3);
    setState(() {});
    if (int.parse(
            '${counter3 % (is33 ? 33 : 99) == 0 ? counter3 == 0 ? 0 : (counter3 - 1) % (is33 ? 33 : 99) + 1 : counter3 % (is33 ? 33 : 99)}') ==
        33) {
      Vibrate.feedback(FeedbackType.heavy);
    }

    // save hive
    box.put('tasbehSoni', counter3);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 28.h,
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 96, 44, 40),
      ),

      //drawer
      drawer: const Drawer1(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //
            // bar image box
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 1, color: Colors.white)),
                image: DecorationImage(
                  image: AssetImage('assets/images/b1.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: 360.0.w,

              // gradient Container
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0.sp),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.2),
                        const Color(0xff55403C).withOpacity(0.4),
                        const Color(0xff55403C).withOpacity(0.4),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.6),
                      ]),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 10.0.h),

                    // tap icons bar Row
                    SizedBox(
                      width: 150.0.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //  sound icon
                          iconsBar(
                            icon: vibrateTap
                                ? Icons.volume_off_outlined
                                : Icons.volume_up_outlined,
                            onTap: vibrate,
                            size: 23.0.sp,
                          ),

                          // container 33 end 99
                          cantroller(),

                          // replay icon clear
                          iconsBar(
                            icon: Icons.replay,
                            onTap: () {
                              counter3 = 0;
                              setState(() {});
                              box.put('tasbehSoni', counter3);
                            },
                            size: 21.0.sp,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0.h),

                    // 33 / 99 Container row
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    '${counter3 % (is33 ? 33 : 99) == 0 ? counter3 == 0 ? 0 : (counter3 - 1) % (is33 ? 33 : 99) + 1 : counter3 % (is33 ? 33 : 99)}',
                                style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                  fontSize: 55.0.sp,
                                  fontWeight: FontWeight.w700,
                                )),
                            TextSpan(
                                text: '  / ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w700,
                                )),
                            TextSpan(
                              text: '${(is33 ? 33 : 99)}',
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 20.0.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.0.h),

                    // all zikir Total
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text('Total: $counter3',
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    SizedBox(height: 20.0.h),
                  ],
                ),
              ),
            ),

            // onTap main  counter controllor (:
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.white)),
                  color: Color.fromARGB(255, 96, 44, 40),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.0.h),
                    Text(
                        zikirList[(counter3 ~/ (is33 ? 33 : 99)) %
                            (zikirList.length)],
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontSize: 25.0.sp,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 30.0.h),
                    GestureDetector(
                      onTap: (() {
                        controller2();
                      }),
                      child: Container(
                        width: 250.0.w,
                        height: 300.0.h,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(30.0.sp),
                          color: const Color.fromARGB(255, 102, 55, 51),
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
  }

  GestureDetector cantroller() {
    return GestureDetector(
      onTap: () {
        is33 = !is33;
        setState(() {});
      },
      child: Container(
        width: 40.0.w,
        height: 26.0.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0.sp),
            border: Border.all(width: 1, color: Colors.white),
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 96, 44, 40).withOpacity(0.6),
              const Color.fromARGB(255, 96, 44, 40).withOpacity(0.6),
            ])),
        child: Center(
          child: Text(
            "${(is33 ? 33 : 99)}",
            style: GoogleFonts.quicksand(
              color: Colors.white,
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Container iconsBar({
    required IconData? icon,
    required GestureTapCallback? onTap,
    double? size,
  }) {
    return Container(
      child: IconButton(
        onPressed: onTap!,
        icon: Icon(icon!),
        color: Colors.white,
        iconSize: size,
      ),
    );
  }
}
