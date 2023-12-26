import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/screen/add_post_screen.dart';
import 'package:instagram_clone/screen/feed_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {

  int _currentIndex=0;

  final List tabItem=[
    const FeedScreen(),
    const Center(child: Text("Search Page"),),
    const AddPostScreen(),
    const Center(child: Text("Video Page"),),
    const Center(child: Text("Profile Page"),)
  ];




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: tabItem[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 28,
        onTap: (index){
          _currentIndex=index;
          setState(() {});
        },
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color:_currentIndex==0?primaryColor: primaryColor.withOpacity(0.5),),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,color:_currentIndex==1?primaryColor: primaryColor.withOpacity(0.5),),
              label: "",

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded,color:_currentIndex==2?primaryColor: primaryColor.withOpacity(0.5),),
              label: "",

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_outlined,color:_currentIndex==3?primaryColor: primaryColor.withOpacity(0.5),),
              label: "",

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined,color:_currentIndex==4?primaryColor: primaryColor.withOpacity(0.5),),
              label: "",

          ),
        ],
      ),
    );
  }
}
