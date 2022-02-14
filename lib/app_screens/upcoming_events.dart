import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:gdsc_lnct/app_screens/about_event.dart';
import 'package:gdsc_lnct/models/data_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

enum EventType { upcoming, past, pastEvents }

class ListEvents extends StatelessWidget {
  ListEvents({Key? key, required this.event}) : super(key: key);
  final EventType event;
  final firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataProvider>(context);
    return SizedBox(
      height: (event == EventType.past) ? 870.h : null,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection:
            (event == EventType.upcoming || event == EventType.pastEvents)
                ? Axis.vertical
                : Axis.horizontal,
        physics: (event == EventType.upcoming)
            ? const NeverScrollableScrollPhysics()
            : null,
        itemCount: (event == EventType.upcoming)
            ? data.upcomingEvents.length
            : data.pastEvents.length,
        itemBuilder: (_, index) {
          String heading = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['heading']
              : data.pastEvents[index]['heading'];
          String date = (event == EventType.upcoming)
              ? data.upcomingEvents[index]['date']
              : data.pastEvents[index]['date'];
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
              child: (event == EventType.upcoming ||
                      event == EventType.pastEvents)
                  ? Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 40.h),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageURL ??
                                'https://media.istockphoto.com/vectors/error-page-dead-emoji-illustration-vector-id1095047472?k=20&m=1095047472&s=612x612&w=0&h=1lDW_CWDLYwOUO7tAsLHnXTSwuvcWqWq4rysM1y6-E8=',
                            imageBuilder: (context, imageProvider) =>
                                Container(
                              height: 500.sp,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider)),
                            ),
                            placeholder: (context, url) => Container(
                              height: 600.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: BlurHash(
                                imageFit: BoxFit.cover,
                                duration: const Duration(seconds: 10),
                                curve: Curves.linear,
                                hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                                image: url,
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                                child: SizedBox(
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
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        date,
                                        maxLines: 1,
                                        minFontSize: 42.sp,
                                        style: GoogleFonts.poppins(
                                            fontSize: 49.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent),
                                      ),
                                    ),
                                    if (rsvpLink != null || watchLink != null)
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20)),
                                            primary: Colors.blueAccent),
                                        onPressed: () async {
                                          String? url;
                                          if (watchLink != null) {
                                            url = watchLink;
                                          } else {
                                            url = rsvpLink;
                                          }

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
                      ))
                  : pastEvents(
                      imageURL: imageURL,
                      event: event,
                      heading: heading,
                      date: date,
                      rsvpLink: rsvpLink,
                      watchLink: watchLink),
            ),
          );
        },
      ),
    );
  }
}

Widget pastEvents(
    {required String? imageURL,
    required EventType event,
    required String heading,
    required String date,
    required String? rsvpLink,
    required String? watchLink}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: 600.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: imageURL ??
                    'https://media.istockphoto.com/vectors/error-page-dead-emoji-illustration-vector-id1095047472?k=20&m=1095047472&s=612x612&w=0&h=1lDW_CWDLYwOUO7tAsLHnXTSwuvcWqWq4rysM1y6-E8=',
                imageBuilder: (context, imageProvider) => Container(
                  height: 400.h,
                  width: 600.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: (event == EventType.past)
                              ? ColorFilter.mode(Colors.black.withOpacity(0.8),
                                  BlendMode.dstATop)
                              : null,
                          image: imageProvider)),
                ),
                placeholder: (context, url) => Container(
                  height: 400.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BlurHash(
                    imageFit: BoxFit.cover,
                    duration: const Duration(seconds: 10),
                    curve: Curves.linear,
                    hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                    image: url,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                    child: SizedBox(
                        height: 400.sp,
                        child: Icon(
                          Icons.error,
                          color: Colors.red[900],
                        ))),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 30.h,
                ),
                height: 320.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        heading,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 50.sp,
                            color: (event == EventType.upcoming)
                                ? Colors.black87
                                : Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        date,
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
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
  );
}
