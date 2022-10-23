import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasbeh/utils/app_drawer.dart';
import 'package:text_scroll/text_scroll.dart';

class Zikirs extends StatefulWidget {
  static const id = 'zikirs';
  String? infoZikir;
  Zikirs({super.key, this.infoZikir});

  @override
  State<Zikirs> createState() => _ZikirsState();
}

class _ZikirsState extends State<Zikirs> {
  late int counter3 = 0;
  bool vibrateTap = true;

  var box;

  // vibrate icon controllor
  void vibrate() {
    vibrateTap = !vibrateTap;
    setState(() {});
  }

  @override
  void initState() {
    box = Hive.box('db');
    counter3 = box.get('zikiris') ?? 0;
    super.initState();
  }

// vibrate icon controllor
  void controller2() {
    if (vibrateTap == false) {
      Vibrate.feedback(FeedbackType.heavy);
    }
    counter3++;
    setState(() {});
    box.put('zikiris', counter3);
  }

  @override
  void dispose() {
    super.dispose();
    counter3;
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
            // bar image Container
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 1, color: Colors.white)),
                image: DecorationImage(
                  image: AssetImage('assets/images/b1.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: 360.0.w,
              height: 200.0.h,

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10.0.h),

                    // tap icons bar
                    SizedBox(
                      width: 150.0.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //  sound icon
                          iconsBar(
                            icon: vibrateTap
                                ? Icons.volume_off_outlined
                                : Icons.volume_up_outlined,
                            onTap: vibrate,
                            size: 23.0.sp,
                          ),

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

                    const Spacer(),

                    // zikirlar
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text('$counter3',
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 50.0.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    SizedBox(height: 20.0.h),
                  ],
                ),
              ),
            ),

            // onTap main  counter controllor (:
            onTapContainer(),
          ],
        ),
      ),
    );
  }

  Expanded onTapContainer() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.white)),
          color: Color.fromARGB(255, 96, 44, 40),
        ),
        child: Column(
          children: [
            SizedBox(height: 20.0.h),

            ///
            TextScroll(
              widget.infoZikir!.toString(),
              mode: TextScrollMode.bouncing,
              velocity: const Velocity(pixelsPerSecond: Offset(50, 1000)),
              delayBefore: const Duration(seconds: 2),
              numberOfReps: 100,
              pauseBetween: const Duration(seconds: 2),
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontSize: 30.0.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
              selectable: true,
            ),

            //
            SizedBox(height: 30.0.h),
            GestureDetector(
              onTap: controller2,
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
    );
  }
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
