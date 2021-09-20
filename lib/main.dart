import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdsc_lnct/intro_screens/intropage.dart';
import 'package:gdsc_lnct/models/dataprovider.dart';
import 'package:gdsc_lnct/app_screens/navigator.dart';
import 'package:gdsc_lnct/models/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

bool? showIntro;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  showIntro = preferences.getBool('showIntro');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 2340),
      builder: () => ChangeNotifierProvider(
        create: (_) => DataProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context), child: child ?? Container()),
          title: 'GDSC-LNCT',
          home: (showIntro == true || showIntro == null)
              ? IntroPage()
              : HomePageNavigation(),
        ),
      ),
    );
  }
}
