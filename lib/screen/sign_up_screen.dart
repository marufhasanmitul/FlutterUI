import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2,child: Container(),),
              SvgPicture.asset('assets/instagram.svg',color: primaryColor,height: 64,),
              const SizedBox(height: 64,),
              //Circular Widget
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage("https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                  ),
                  Positioned(
                     bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {  },
                        icon: Icon(Icons.add_a_photo),
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
                textEditingController:_emailController,
                hintText: 'Enter Your Bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24,),
              InkWell(
                onTap: (){},
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
                  child: const Text('Log in'),
                ),
              ),
              const SizedBox(height: 12,),
              Flexible(flex: 2,child: Container(),),
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
    );
  }
}
