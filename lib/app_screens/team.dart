import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdsc_lnct/app_screens/panel_widget.dart';
import 'package:gdsc_lnct/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OurTeam extends StatelessWidget {
  final String teamText =
      'We are a group of excited people with a clear sense of purpose. We believe in continous learning and development. The motive is to create a local ecosystem of programmers & hackers in and around the campus. The technology awareness is main goal for our community.';

  const OurTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 0.55.sh,
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      maxHeight: 1.sh,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      body: SizedBox(
    height: 0.4.sh,
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
                'Our Team',
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
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: AutoSizeText(
            teamText,
            maxLines: 7,
            style: GoogleFonts.poppins(
                fontSize: 50.sp, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
      ),
      panelBuilder: (controller) => PanelWidget(controller: controller),
    );
  }
}
