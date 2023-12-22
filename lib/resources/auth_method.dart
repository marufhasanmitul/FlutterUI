import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _fireStore =FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser= _auth.currentUser!;
    DocumentSnapshot snapshot=await _fireStore.collection('user').doc(currentUser.uid).get();
    return UserModel.fromSnap(snapshot);
  }

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


        UserModel userModel = UserModel(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl
        );


        //add user to our Database
        await _fireStore.collection('user').doc(cred.user!.uid).set(userModel.toJson());


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

  //Login user

  Future<String> loginUser({required String email,required String password})async{
    String res="Some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      }else{
        res="Please enter all the Fields";
      }
      res="success";
    }catch(err){
      res=err.toString();
    }


    return res;
  }











}