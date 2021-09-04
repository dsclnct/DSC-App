import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdsc_lnct/models/coremembers.dart';
import 'package:gdsc_lnct/models/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PanelWidget extends StatelessWidget {
  PanelWidget({Key? key, required this.controller}) : super(key: key);
  final ScrollController controller;

  final List<Color> colour = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.orange
  ];

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : showToast(message: "Couldn't Launch URL");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 65.w,
      ),
      child: ListView(
        controller: controller,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100.w,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 60.h),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 18,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: (index < 17) ? 70.h : 350.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        DashedCircle(
                          color: colour[index % 4],
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 120.sp,
                              backgroundImage: AssetImage(
                                  'core members/${coreMembers[index]["image"]}'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${coreMembers[index]["name"]}',
                                style: GoogleFonts.poppins(
                                    color: colour[index % 4],
                                    fontSize: 52.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                '${coreMembers[index]["domain"]}',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade700,
                                  fontSize: 42.sp,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (coreMembers[index]["linkedin"] != null)
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.linkedin,
                                        size: 60.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        _launchURL(coreMembers[index]
                                                ["linkedin"] ??
                                            '');
                                      },
                                      padding: EdgeInsets.only(
                                        right: 8,
                                      ),
                                      splashColor: Colors.red,
                                    ),
                                  if (coreMembers[index]["github"] != null)
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.github,
                                        size: 60.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        _launchURL(
                                            coreMembers[index]["github"] ?? '');
                                      },
                                      padding: EdgeInsets.only(
                                        right: 8,
                                      ),
                                    ),
                                  if (coreMembers[index]["link"] != null)
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.link,
                                        size: 60.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        _launchURL(
                                            coreMembers[index]["link"] ?? '');
                                      },
                                      padding: EdgeInsets.only(
                                        right: 8,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  MemberCard({required this.index, required this.selectedIndex});
  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
