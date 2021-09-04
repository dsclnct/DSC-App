import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdsc_lnct/app_screens/navigator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'screen1.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final controller = PageController();

  int currentIndex = 0;
  double percent = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                  percent = 0.5 * currentIndex;
                });
              },
              controller: controller,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Screen(index: index);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: CircularPercentIndicator(
                  radius: 100.0,
                  animation: true,
                  animationDuration: 200,
                  animateFromLastPercent: true,
                  lineWidth: 3.0,
                  percent: percent,
                  center: GestureDetector(
                    onTap: () async {
                      if (currentIndex < 2) {
                        setState(() {
                          controller.animateToPage(currentIndex + 1,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.linear);
                        });
                      } else {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.setBool('showIntro', false);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => HomePageNavigation(),
                            ),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black87,
                      ),
                      child: Center(
                          child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  progressColor: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
