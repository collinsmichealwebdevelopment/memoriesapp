import 'package:firebase_core/firebase_core.dart';
import 'package:memories/screens/LandingPage/landingHelpers.dart';
import 'package:memories/screens/LandingPage/landingServices.dart';
import 'package:memories/screens/splashscreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:memories/constant/Constantcolors.dart';
import 'package:memories/utils/PostOptions.dart';
import 'package:provider/provider.dart';
import 'package:memories/services/Authentication.dart';
import 'package:memories/screens/landingpage/landingUtils.dart';
import 'package:memories/screens/Feed/Feed_helpers.dart';
import 'package:memories/services/Firebaseoperations.dart';
import 'package:memories/screens/Profile/ProfileHelpers.dart';
import 'package:memories/screens/homepage/HomepageHelpers.dart';
import 'package:memories/utils/UploadPost.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyA6khQvAuhBJ1NU3r3mZkNhQX9lKf1fWac',
        appId: '1036411165698-2p1kddop1gdk0mhb7b5jj7jubkbvrj62.apps.googleusercontent.com',
        messagingSenderId: 'sendid',
        projectId: 'memories-feddb',
        storageBucket: 'memories-feddb.appspot.com',
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PostFunctions()),
          ChangeNotifierProvider(create: (_) => FeedHelpers()),
          ChangeNotifierProvider(create: (_) => UploadPost()),
          ChangeNotifierProvider(create: (_) => ProfileHelpers()),
          ChangeNotifierProvider(create: (_) => HomepageHelpers()),
          ChangeNotifierProvider(create: (_) => LandingUtils()),
          ChangeNotifierProvider(create: (_) => Firebaseoperations()),
          ChangeNotifierProvider(create: (_) => LandingService()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => LandingHelpers())
        ],
        child: MaterialApp(
          home: const Splashscreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              hintColor: constantColors.blueColor,
              canvasColor: Colors.transparent),
        )
    );
  }
}
