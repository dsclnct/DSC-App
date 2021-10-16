import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdsc_lnct/models/dataprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'upcomingevents.dart';

class AboutEvent extends StatefulWidget {
  const AboutEvent({Key? key, required this.index, required this.event})
      : super(key: key);
  final int index;
  final EventType event;

  @override
  _AboutEventState createState() => _AboutEventState();
}

class _AboutEventState extends State<AboutEvent> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late String heading;
  late String? subHeading;
  late String date;
  late String time;
  late String? image;
  late String? discription;
  late List<dynamic>? tags;
  late String? venue;
  late String? watchLink;
  late String? rsvpLink;
  late DateTime d;

  bool changeFit = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    var data = Provider.of<DataProvider>(context, listen: false);
    heading = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['heading']
        : data.pastEvents[widget.index]['heading'];
    subHeading = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['subHeading']
        : data.pastEvents[widget.index]['subHeading'];
    date = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['date']
        : data.pastEvents[widget.index]['date'];
    time = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['time']
        : data.pastEvents[widget.index]['time'];
    rsvpLink = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['rsvpLink']
        : data.pastEvents[widget.index]['rsvpLink'];
    watchLink = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['watchLink']
        : data.pastEvents[widget.index]['watchLink'];
    image = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['image']
        : data.pastEvents[widget.index]['image'];

    discription = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['description']
        : data.pastEvents[widget.index]['description'];

    venue = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['venue']
        : data.pastEvents[widget.index]['venue'];

    tags = (widget.event == EventType.upcoming)
        ? data.upcomingEvents[widget.index]['tags']
        : data.pastEvents[widget.index]['tags'];
  }

  List<Widget> tagsList() {
    List<Widget> f = [];
    for (String i in tags ?? []) {
      f.add(Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.shade300),
        child: Text(
          i,
          style: GoogleFonts.poppins(
              fontSize: 40.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ));
    }
    return f;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (rsvpLink != null || watchLink != null)
          ? Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 2, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.blueAccent),
                onPressed: () async {
                  String? url;
                  if (widget.event == EventType.upcoming)
                    url = rsvpLink;
                  else if (widget.event == EventType.past) url = watchLink;

                  await canLaunch(url ?? '')
                      ? await launch(url ?? '')
                      : throw 'Could not launch';
                },
                child: Text(
                  (widget.event == EventType.upcoming)
                      ? '   RSVP Now   '
                      : (watchLink != null)
                          ? '   Watch   '
                          : '   Details   ',
                  style: GoogleFonts.poppins(
                      fontSize: 45.sp,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ))
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      changeFit = !changeFit;
                    });
                  },
                  child: CachedNetworkImage(
                    imageUrl: image ??
                        'https://media.istockphoto.com/vectors/error-page-dead-emoji-illustration-vector-id1095047472?k=20&m=1095047472&s=612x612&w=0&h=1lDW_CWDLYwOUO7tAsLHnXTSwuvcWqWq4rysM1y6-E8=',
                    imageBuilder: (context, imageProvider) => Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.white.withOpacity(0.18),
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      height: 900.h,
                      decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.blueAccent, width: 4),
                          ),
                          image: DecorationImage(
                              fit: (changeFit) ? BoxFit.contain : BoxFit.cover,
                              image: imageProvider)),
                    ),
                    placeholder: (context, url) => Container(
                      height: 600.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BlurHash(
                        imageFit: BoxFit.cover,
                        duration: Duration(seconds: 10),
                        curve: Curves.bounceInOut,
                        hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                        image: url,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                        child: Container(
                            height: 300.sp,
                            child: Icon(
                              Icons.error,
                              color: Colors.red[900],
                            ))),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heading,
                        style: GoogleFonts.poppins(
                            fontSize: 60.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      if (subHeading != null)
                        Padding(
                          padding: EdgeInsets.only(top: 30.h, bottom: 70.h),
                          child: Text(
                            '❁  $subHeading',
                            style: GoogleFonts.poppins(
                              fontSize: 47.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      Padding(
                        padding: (subHeading != null)
                            ? EdgeInsets.only(bottom: 50.h)
                            : EdgeInsets.symmetric(vertical: 50.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.solidCalendar,
                                      color: Color(0xff58BBFF),
                                      size: 55.sp,
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      '$date',
                                      style: GoogleFonts.poppins(
                                        fontSize: 50.sp,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 120.w,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.solidClock,
                                      color: Colors.green,
                                      size: 55.sp,
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      '$time',
                                      style: GoogleFonts.poppins(
                                        fontSize: 50.sp,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (venue != null)
                              Padding(
                                padding: EdgeInsets.only(top: 60.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.mapPin,
                                      color: Colors.yellow.shade800,
                                      size: 55.sp,
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      '$venue',
                                      style: GoogleFonts.poppins(
                                        fontSize: 50.sp,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (discription != null)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About',
                                style: GoogleFonts.poppins(
                                    fontSize: 55.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                '$discription',
                                style: GoogleFonts.poppins(
                                  fontSize: 45.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (tags != null && tags!.length != 0)
                        Padding(
                          padding: EdgeInsets.only(top: 50.h, bottom: 100.h),
                          child: Wrap(
                            spacing: 20.w,
                            runSpacing: 30.h,
                            children: tagsList(),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
