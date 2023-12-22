import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';

import '../widgets/text_field_input.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passController=TextEditingController();
  final TextEditingController _bioController=TextEditingController();
  final TextEditingController _userNameController=TextEditingController();

  Uint8List? _image;



  void selectImage()async{
    Uint8List im=await pickImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(
                  height: screenSize.height*0.05,
                ),
                SvgPicture.asset('assets/instagram.svg',color: primaryColor,height: 64,),
                const SizedBox(height: 64,),
                //Circular Widget
                Stack(
                  children: [

                    _image!=null?CircleAvatar(
                      radius: 64,
                      backgroundImage:MemoryImage(_image!),
                    ):const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqEdjObQlFk57DJp5nZDb45UuAJG_TMlFJ_pgWX2VwWA&s"),
                    ),


                    Positioned(
                       bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed:selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        )
                    )

                  ],
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController:_userNameController,
                  hintText: 'Enter Your username',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController:_emailController,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController:_passController,
                  hintText: 'Enter Your Password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController:_bioController,
                  hintText: 'Enter Your Bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: () async {
                    String res = await AuthMethods().signUpUser(
                        email: _emailController.text,
                        password: _passController.text,
                        username: _userNameController.text,
                        bio: _bioController.text
                    );
                    print(res);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: const ShapeDecoration(
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                        color: blueColor
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(height: 12,),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Log In",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),
                //login Button
                //Transition to Sign up
              ],
            ),
          ),
        ),
      ),
    );
  }
}
