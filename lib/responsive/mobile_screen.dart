import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {




  @override
  Widget build(BuildContext context) {

   final UserModel? user=Provider.of<UserProvider>(context).getUser;

    return  Scaffold(
      body: user==null ?const Center(child: CircularProgressIndicator(color: primaryColor,),):Center(child: Text('${user.email??""}')),
    );
  }
}
