import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen.dart';
import 'package:instagram_clone/screen/login_screen.dart';
import 'package:instagram_clone/screen/sign_up_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCgKu6u8f8yRWQrN24zinghulTwUxTQkhE",
          authDomain: "instagram-9da78.firebaseapp.com",
          projectId: "instagram-9da78",
          storageBucket: "instagram-9da78.appspot.com",
          messagingSenderId: "86893489473",
          appId: "1:86893489473:web:001ce88914ac47992b45c0"
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
      //home:const ResponsiveLayoutScreen(mobileScreen: MobileScreen(), webScreen: WebScreen(),)
      //home: const LoginScreen(),
      //home: const SignUpScreen(),

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.active){

            if(snapshot.hasData){
              return const ResponsiveLayoutScreen(mobileScreen: MobileScreen(), webScreen: WebScreen(),);
            }else if(snapshot.hasError){
              return Center(child: Text("${snapshot.hasError}"),);
            }


          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(color:primaryColor,),);
          }

          return const LoginScreen();

        },


      ),

    );
  }
}

