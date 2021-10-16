import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:gdsc_lnct/app_screens/about.dart';
import 'package:gdsc_lnct/app_screens/pastEvents.dart';
import 'package:gdsc_lnct/app_screens/team.dart';
import 'package:gdsc_lnct/models/dataprovider.dart';
import 'package:gdsc_lnct/models/notification_service.dart';
import 'package:gdsc_lnct/models/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import 'upcomingevents.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gdsc_lnct/models/themeprovider.dart';

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
                color: Theme.of(context).primaryColor,
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
        //activeColor: Colors.grey.shade100,
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
    data.bannerInfo.clear();
    await data.loadEvents();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataProvider>(context);
    Themechanger themechanger = Provider.of<Themechanger>(context);
    return (showLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SmartRefresher(
            enablePullDown: true,
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
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20.w),
                                  child: AutoSizeText(
                                    'Developer Student Club',
                                    maxLines: 1,
                                    style: GoogleFonts.poppins(
                                        fontSize: 70.sp,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Tab(
                                child: CircleAvatar(
                                    radius: 55.sp,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      'images/gdsclogo.png',
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Lakshmi Narain College of Technology',
                                style: GoogleFonts.poppins(
                                    fontSize: 45.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 100.w),
                              Icon(themechanger.getDarkMode()
                                  ? Icons.dark_mode
                                  : Icons.light_mode),
                              Switch(
                                value: themechanger.getDarkMode(),
                                onChanged: (value) {
                                  setState(() {
                                    themechanger.changeDarkMode(value);
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  kcoloredLine,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.bannerInfo.length > 0) Banner(),
                      Container(
                        margin: EdgeInsets.only(
                            top: 50.h, bottom: 20.h, left: 50.w),
                        child: Text(
                          'Upcoming Events',
                          style: GoogleFonts.poppins(
                              fontSize: 57.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600),
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
                              top: 50.h, left: 50.w, right: 50.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Past Events',
                                style: GoogleFonts.poppins(
                                    fontSize: 57.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PastEvent()));
                                  },
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ))
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

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: false,
            height: 350.h,
            viewportFraction: 0.87,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: (data.bannerInfo.length == 1) ? false : true,
            autoPlay: true,
          ),
          items: bannerItems(data)),
    );
  }
}

List<Widget> bannerItems(DataProvider data) {
  List<Widget> items = [];
  for (int i = 0; i < data.bannerInfo.length; i++) {
    if (data.bannerInfo[i]['title'] == null) {
      items.add(GestureDetector(
        onTap: () async {
          if (data.bannerInfo[i]['link'] != null) {
            String url = data.bannerInfo[i]['link'];
            await canLaunch(url)
                ? await launch(url)
                : showToast(message: "Couldn't Launch Link");
          }
        },
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: data.bannerInfo[i]['backgroundImage'] ??
                  'https://media.istockphoto.com/vectors/error-page-dead-emoji-illustration-vector-id1095047472?k=20&m=1095047472&s=612x612&w=0&h=1lDW_CWDLYwOUO7tAsLHnXTSwuvcWqWq4rysM1y6-E8=',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
              ),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BlurHash(
                  imageFit: BoxFit.cover,
                  duration: Duration(seconds: 10),
                  curve: Curves.linear,
                  hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                  image: url,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red.shade800,
                    ),
                    Text('Something went wrong!')
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
    }
  }

  return items;
}
