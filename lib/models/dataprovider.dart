import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<dynamic> upcomingEvents = [];
  List<dynamic> pastEvents = [];
  List<dynamic> bannerInfo = [];
  bool error = false;

  Future<void> loadEvents() async {
    try {
      error = false;
      final banner = await _firestore.collection('banner').get();
      final events = await _firestore.collection('events').get();
      for (var event in events.docs) {
        if ((event.data()['isEventOver']) == true &&
            (event.data()['heading']) != null &&
            (event.data()['date']) != null &&
            (event.data()['time']) != null) {
          pastEvents.add(event.data());
        } else if ((event.data()['isEventOver']) == false &&
            (event.data()['heading']) != null &&
            (event.data()['date']) != null &&
            (event.data()['time']) != null) {
          upcomingEvents.add(event.data());
        }
      }

      for (var b in banner.docs) {
        bannerInfo.add(b.data());
      }
    } catch (e) {
      print(e);
      error = true;
    }
    notifyListeners();
  }
}
