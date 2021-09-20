import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:gdsc_lnct/app_screens/aboutevent.dart';
import 'package:gdsc_lnct/models/dataprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

enum EventType { upcoming, past }

class ListEvents extends StatelessWidget {
  ListEvents({Key? key, required this.event}) : super(key: key);
  final EventType event;
  final firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataProvider>(context);
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: (event == EventType.upcoming)
            ? data.upcomingEvents.length
            : data.pastEvents.length,
        itemBuilder: (_, index) {
          String heading = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['heading']
              : data.pastEvents[index]['heading'];
          String? subheading = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['subHeading']
              : data.pastEvents[index]['subHeading'];
          String date = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['date']
              : data.pastEvents[index]['date'];
          String time = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['time']
              : data.pastEvents[index]['time'];
          String? rsvpLink = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['rsvpLink']
              : data.pastEvents[index]['rsvpLink'];
          String? watchLink = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['watchLink']
              : data.pastEvents[index]['watchLink'];
          String? imageURL = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['image']
              : data.pastEvents[index]['image'];
          return Material(
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            AboutEvent(index: index, event: event)));
              },
              child: Card(
                  margin:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: imageURL ??
                              'https://media.istockphoto.com/vectors/error-page-dead-emoji-illustration-vector-id1095047472?k=20&m=1095047472&s=612x612&w=0&h=1lDW_CWDLYwOUO7tAsLHnXTSwuvcWqWq4rysM1y6-E8=',
                          imageBuilder: (context, imageProvider) => Container(
                            height: 500.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: (event == EventType.past)
                                        ? ColorFilter.mode(
                                            Colors.black.withOpacity(0.8),
                                            BlendMode.dstATop)
                                        : null,
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
                              curve: Curves.linear,
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
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 50.w,
                            vertical: 30.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                heading,
                                style: GoogleFonts.poppins(
                                    fontSize: 55.sp,
                                    color: (event == EventType.upcoming)
                                        ? Colors.black87
                                        : Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      '$date  | $time',
                                      maxLines: 1,
                                      minFontSize: 42.sp,
                                      style: GoogleFonts.poppins(
                                        fontSize: 49.sp,
                                        fontWeight: FontWeight.w500,
                                        color: (event == EventType.upcoming)
                                            ? Colors.blueAccent
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  if (rsvpLink != null || watchLink != null)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          primary: Colors.blueAccent),
                                      onPressed: () async {
                                        String? url;
                                        if (watchLink != null)
                                          url = watchLink;
                                        else
                                          url = rsvpLink;

                                        await canLaunch(url ?? '')
                                            ? await launch(url ?? '')
                                            : throw 'Could not launch';
                                      },
                                      child: Text(
                                        (event == EventType.upcoming)
                                            ? '   RSVP Now   '
                                            : (watchLink != null)
                                                ? '   Watch   '
                                                : '   Details   ',
                                        style: GoogleFonts.poppins(
                                            fontSize: 45.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
// ListTile(
// title: Text(),
// ),
