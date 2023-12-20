import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCWE-5IgLEW9YN80YtL6fZDog2NwF70vYE",
          appId: "1:957025831472:web:c69b8dfc104bf7c3457bf5",
          messagingSenderId: "957025831472",
          projectId: "instagram-eec68",
          storageBucket: "instagram-eec68.appspot.com"
      )
    );
  }else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: webBackgroundColor
      ),
      home:const ResponsiveLayoutScreen(mobileScreen: MobileScreen(), webScreen: WebScreen(),)
    );
  }
}

