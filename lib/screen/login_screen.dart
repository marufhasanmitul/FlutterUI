import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';

import '../widgets/text_field_input.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passController=TextEditingController();

 @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2,child: Container(),),
              SvgPicture.asset('assets/instagram.svg',color: primaryColor,height: 64,),
              const SizedBox(height: 64,),
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
                      child: const Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold),),
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
