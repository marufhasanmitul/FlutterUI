import 'package:flutter/material.dart';
import '../utils/dimension.dart';
class ResponsiveLayoutScreen extends StatelessWidget {
  final Widget mobileScreen;
  final Widget webScreen;
  const ResponsiveLayoutScreen({super.key, required this.mobileScreen, required this.webScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints){
          if(constraints.maxWidth > webScreenSize){
            return webScreen;
          }
          return mobileScreen;
        }
    );
  }
}
