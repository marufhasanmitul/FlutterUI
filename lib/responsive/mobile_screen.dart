import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  String userName="";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName()async{
    DocumentSnapshot snapshot=await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();


    setState(() {
      userName =(snapshot.data() as Map<String,dynamic>)['username'];

    });
    print(userName);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text('$userName')),
    );
  }
}
