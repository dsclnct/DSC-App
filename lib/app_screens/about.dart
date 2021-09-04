import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdsc_lnct/constants.dart';
import 'package:gdsc_lnct/models/toast.dart';
import 'package:gdsc_lnct/models/urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUs extends StatelessWidget {
  final String aboutText =
      'Google Developer Student Clubs are university-based community groups for students interested in Google developer technologies. Students from all undergraduate or graduate programs with an interest in growing as a developer are welcome. By joining a GDSC, students grow their knowledge in a peer-to-peer learning environment and build solutions for local businesses and their communities.\nOur chapter mission is to Build, Learn and Grow.';

  Widget socialIcon(String icon, Url name) {
    return GestureDetector(
      onTap: () {
        if (name == Url.spotify)
          showToast(message: 'Coming Soon');
        else
          URL().launchURL(name);
      },
      child: Container(
        margin: EdgeInsets.only(right: 80.w),
        child: Tab(
            child: CircleAvatar(
                radius: 45.sp,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'images/$icon',
                ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'About Us',
                    style: GoogleFonts.poppins(
                        fontSize: 85.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                  Tab(
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          'images/gdsclogo.png',
                        )),
                  ),
                ],
              ),
            ),
            kcoloredLine,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    aboutText,
                    style: GoogleFonts.poppins(
                        fontSize: 50.sp, color: Colors.grey.shade800),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      socialIcon('linkedin.png', Url.linkedin),
                      socialIcon('facebook.png', Url.facebook),
                      socialIcon('instagram.png', Url.insta),
                      socialIcon('youtube.png', Url.youtube),
                      socialIcon('spotify.png', Url.spotify),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        URL().launchURL(Url.web);
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.blue.shade600,
                          ),
                        ),
                        child: Text(
                          'Our Official Website',
                          style: GoogleFonts.poppins(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Text(
                    'Join Our Community',
                    style: GoogleFonts.poppins(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 50.h),
                    child: Text(
                      'Backed by a vast community of driven, passionate learners. Easy access to a huge pool of change-makers & renowned personalities.',
                      style: GoogleFonts.poppins(
                          fontSize: 45.sp, color: Colors.grey.shade800),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 50.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue.shade700),
                                  height: 50.sp,
                                  width: 50.sp),
                            ),
                            DottedLine(
                              direction: Axis.vertical,
                              lineLength: 180.h,
                              dashColor: Colors.blue.shade700,
                              lineThickness: 2,
                            ),
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue.shade700),
                                  height: 50.sp,
                                  width: 50.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () {
                                URL().launchURL(Url.gdsc);
                              },
                              child: Text(
                                'Become a Member',
                                style: GoogleFonts.poppins(
                                    fontSize: 45.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                          SizedBox(
                            height: 100.h,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () {
                                URL().launchURL(Url.discord);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(FontAwesomeIcons.discord),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Text(
                                    '  Join Discord',
                                    style: GoogleFonts.poppins(
                                        fontSize: 45.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Text(
                    'Tracks',
                    style: GoogleFonts.poppins(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
            Container(
              height: 600.h,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 50.w,
                  ),
                  Tracks(
                    image: 'css.png',
                    text: 'Web\nDevelopment',
                    colour: Color(0xffFFB167),
                  ),
                  Tracks(
                    image: 'flutter.png',
                    text: 'App\nDevelopment',
                    colour: Colors.blue,
                  ),
                  //SizedBox(width: 20.w),

                  Tracks(
                    image: 'ui.png',
                    text: 'UI/UX\Design',
                    colour: Colors.green,
                    radius: 30,
                  ),
                  Tracks(
                    image: 'brain.png',
                    text: 'ML & Cloud',
                    colour: Colors.grey,
                    radius: 30,
                  ),
                  Tracks(
                    image: 'arvr.png',
                    text: 'AR & VR',
                    colour: Colors.yellow,
                    radius: 30,
                  ),
                  Tracks(
                    image: 'git.png',
                    text: 'Open Source',
                    colour: Colors.orange,
                    radius: 50,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Events we conduct',
                    style: GoogleFonts.poppins(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                  Events(
                    image: 'online-class.png',
                    text: 'Webinars',
                  ),
                  Events(
                    image: 'shuttle.png',
                    text: 'Projects',
                  ),
                  Events(
                    image: 'trophy.png',
                    text: 'Hackathons',
                  ),
                  Events(
                    image: 'headphones.png',
                    text: 'Podcasts',
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Events extends StatelessWidget {
  const Events({required this.image, required this.text});
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 80.h),
      child: Row(
        children: [
          Tab(
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'images/$image',
                )),
          ),
          SizedBox(
            width: 100.w,
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 60.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }
}

class Tracks extends StatelessWidget {
  const Tracks(
      {required this.image,
      required this.text,
      required this.colour,
      this.radius});
  final String image;
  final String text;
  final Color colour;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.only(top: 20, right: 25, bottom: 20, left: 5),
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: EdgeInsets.only(bottom: 50.h, left: 30.w),
            height: 450.h,
            width: 400.w,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 160.h,
          child: Container(
            decoration: BoxDecoration(
                color: colour, borderRadius: BorderRadius.circular(15)),
            width: 300.h,
            height: 300.h,
            child: Center(
              child: CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'images/$image',
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
