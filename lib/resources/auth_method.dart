import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _fireStore =FirebaseFirestore.instance;

  //SignUp user
  Future<String> signUpUser({
      required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file,
    })async{


    String res="Some Error Occurred";

    try{

      if(email.isNotEmpty || password.isNotEmpty ||bio.isNotEmpty || file!=null){
        //Register User
        UserCredential cred= await _auth.createUserWithEmailAndPassword(email: email, password: password);

        print(cred.user!.uid);

        String photoUrl=await StorageMethods().uploadImageToStorage('profilePic', file, false);

        //add user to our Database
        await _fireStore.collection('user').doc(cred.user!.uid).set({
          'username':username,
          'uid':cred.user!.uid,
          'email':email,
          'bio':bio,
          'followers':[],
          'following':[],
          'photoUrl':photoUrl,

        });


        // await _fireStore.collection('user').add({
        //   'username':username,
        //   'uid':cred.user!.uid,
        //   'email':email,
        //   'bio':bio,
        //   'followers':[],
        //   'following':[],
        // });




        res="Success";

      }

    }catch(err){
      res=err.toString();
    }

    return res;




  }











}