import 'package:flutter/material.dart';
import 'package:gdsc_lnct/app_screens/navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.only(bottom: 40),
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
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear);
                        });
                      } else {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.setBool('showIntro', false);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomePageNavigation(),
                            ),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black87,
                      ),
                      child: const Center(
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
