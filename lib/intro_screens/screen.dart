import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdsc_lnct/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen extends StatelessWidget {
  const Screen({required this.index, Key? key}) : super(key: key);
  final int index;

  String getTitle() {
    if (index == 0) {
      return 'Live learning sessions\nhosted by mentors';
    } else if (index == 1) {
      return 'Real-world Relevance';
    } else {
      return 'Awards  &\nplacement opportunities';
    }
  }

  String getSubTitle() {
    if (index == 0) {
      return 'Location independent. Hosted in Virtual classroom systems curated for better learning';
    } else if (index == 1) {
      return 'Focused on tackling practical, real-world tasks and challenges. Guidance from mentors throughout';
    } else {
      return 'A large number of placement opportunities from top companies across industries, multiple new-age career avenues';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kthickColoredLine,
        Expanded(
          flex: 6,
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 0.5.sw,
              child: Image.asset('images/introImage${index + 1}.png')),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  getTitle(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 70.sp,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                AutoSizeText(
                  getSubTitle(),
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade800,
                    fontSize: 50.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
