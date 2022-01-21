import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pali_dictionary/presentation/router/app_router.dart';
import 'package:sizer/sizer.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  Future<void> goToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.popAndPushNamed(context, AppRouter.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    goToHome(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/sbg.png",
            width: 100.w,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/statue.png",
                  width: 50.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Image.asset(
                  "assets/logo.png",
                  width: 70.w,
                  fit: BoxFit.cover,
                ),
                // Text(
                //   "PALI DICTIONARY",
                //   style: TextStyle(
                //     color: Colors.white,
                //     shadows: [
                //       Shadow(
                //           color: Colors.black.withOpacity(0.1),
                //           offset: const Offset(2, 2),
                //           blurRadius: 6)
                //     ],
                //     fontSize: 30.sp,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
