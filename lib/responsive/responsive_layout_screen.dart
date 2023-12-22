import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../utils/dimension.dart';
class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget mobileScreen;
  final Widget webScreen;
  const ResponsiveLayoutScreen({super.key, required this.mobileScreen, required this.webScreen});

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {
  
  @override
  void initState() {
    super.initState();
    addData();
  }
  
  addData()async{
    UserProvider _userProvider=Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints){
          if(constraints.maxWidth > webScreenSize){
            return widget.webScreen;
          }
          return widget.mobileScreen;
        }
    );
  }
}
