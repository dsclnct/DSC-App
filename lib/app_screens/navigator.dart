import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:gdsc_lnct/app_screens/about.dart';
import 'package:gdsc_lnct/app_screens/team.dart';
import 'package:gdsc_lnct/models/dataprovider.dart';
import 'package:gdsc_lnct/models/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../constants.dart';
import 'upcomingevents.dart';

class HomePageNavigation extends StatefulWidget {
  @override
  _HomePageNavigationState createState() => _HomePageNavigationState();
}

class _HomePageNavigationState extends State<HomePageNavigation> {
  List<Widget> screen = [
    AboutUs(),
    Events(),
    OurTeam(),
  ];

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar getAppBar(int index) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'About Us',
            style: GoogleFonts.poppins(
                fontSize: 80.sp,
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
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((value) {});
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      bottomNavigationBar: ConvexAppBar(
        color: Colors.black,
        activeColor: Colors.grey.shade100,
        backgroundColor: Colors.white,
        items: [
          TabItem(
              icon: TabIcon(
                image: 'inactiveAbout',
              ),
              activeIcon: TabIcon(
                image: 'activeAbout',
              )),
          TabItem(
            icon: Tab(
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'images/gdsclogo.png',
                  )),
            ),
          ),
          TabItem(
              icon: TabIcon(
                image: 'inactiveTeam',
              ),
              activeIcon: TabIcon(
                image: 'activeTeam',
              )),
        ],
        initialActiveIndex: 1, //optional, default as 0
        onTap: (int i) => _onItemTapped(i),
      ),
      body: SafeArea(child: screen[_selectedIndex]),
    );
  }
}

class TabIcon extends StatelessWidget {
  const TabIcon({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'images/$image.png',
          )),
    );
  }
}

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  void initState() {
    super.initState();
    init();
  }

  bool showLoading = false;

  Future<void> init() async {
    var data = Provider.of<DataProvider>(context, listen: false);
    if (data.upcomingEvents.length == 0 && data.pastEvents.length == 0) {
      setState(() {
        showLoading = true;
      });
      await data.loadEvents();
      setState(() {
        showLoading = false;
      });
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    var data = Provider.of<DataProvider>(context, listen: false);
    data.upcomingEvents.clear();
    data.pastEvents.clear();
    await data.loadEvents();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataProvider>(context);
    return (showLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SmartRefresher(
            enablePullDown: true,
            //enablePullUp: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            header: ClassicHeader(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Tab(
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                  'images/gdsclogo.png',
                                )),
                          ),
                          Text(
                            'Developer Student Club',
                            style: GoogleFonts.poppins(
                                fontSize: 80.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Lakshmi Narain College of Technology',
                            style: GoogleFonts.poppins(
                                fontSize: 50.sp,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  kcoloredLine,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 50.h, bottom: 40.h, left: 50.w),
                        child: Row(
                          children: [
                            Text(
                              'Upcoming Events',
                              style: GoogleFonts.poppins(
                                  fontSize: 57.sp,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                height: 1,
                                color: Colors.grey.shade400,
                              ),
                            )
                          ],
                        ),
                      ),
                      (data.upcomingEvents.length > 0)
                          ? ListEvents(
                              event: EventType.upcoming,
                            )
                          : Center(
                              child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 120.h),
                                  child: Column(
                                    children: [
                                      Lottie.asset(
                                        'images/noevents.json',
                                        width: 0.7.sw,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        height: 60.h,
                                      ),
                                      Text(
                                        "There isn't any upcoming workshop.\nYou will be notified when there is any.",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: 45.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                      if (data.pastEvents.length > 0)
                        Container(
                          margin: EdgeInsets.only(
                              top: 50.h, bottom: 40.h, left: 50.w),
                          child: Row(
                            children: [
                              Text(
                                'Past Events',
                                style: GoogleFonts.poppins(
                                    fontSize: 57.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  height: 1,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            ],
                          ),
                        ),
                      if (data.pastEvents.length > 0)
                        ListEvents(
                          event: EventType.past,
                        ),
                      SizedBox(
                        height: 150.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
