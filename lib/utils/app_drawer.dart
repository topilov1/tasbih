import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tasbeh/data/data.page.dart';
import 'package:tasbeh/pages/app_Zikirs.dart';
import 'package:tasbeh/pages/namozda/app_namoz.dart';

class Drawer1 extends StatefulWidget {
  const Drawer1({super.key});

  @override
  State<Drawer1> createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 96, 44, 40),
      child: Padding(
        padding: EdgeInsets.only(top: 45.0.h, left: 10.0.h, right: 10.0.sp),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.sp),
                width: double.infinity,
                height: 100.h,
                color: const Color.fromARGB(255, 102, 55, 51),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconDown(),
                    Text(
                      'namoz',
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 30.0.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    iconDown(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: LiquidPullToRefresh(
                backgroundColor: Colors.white,
                borderWidth: 2,
                color: const Color.fromARGB(255, 102, 55, 51),
                height: 200,
                springAnimationDurationInMilliseconds: 1000,

                // after page
                onRefresh: () async {
                  Navigator.of(context).pushNamed(MyHomePage.id);
                },
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        zikir(
                          text: '${zikirlar[index]}',
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Zikirs(infoZikir: zikirlar[index]),
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  }),
                  itemCount: zikirlar.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon iconDown() {
    return Icon(
      Icons.keyboard_double_arrow_down,
      color: Colors.white,
      size: 25.sp,
    );
  }

  Widget zikir({
    required String? text,
    required GestureDoubleTapCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0.h),
                color: const Color.fromARGB(255, 199, 98, 91),
              ),
              padding: EdgeInsets.all(5.0.h),
              width: 60.0,
              height: 60.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Center(
                    child: Text(
                      '$text',
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
