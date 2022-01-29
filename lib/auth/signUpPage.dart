
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:schaffen_software/auth/profile_page.dart';
import 'package:schaffen_software/constant/ColorGlobal.dart';
import 'package:schaffen_software/animation/AnimationBuildLogin.dart';
import 'package:schaffen_software/constant/ColorGlobal.dart';
import 'package:schaffen_software/constant/TextField.dart';
import 'package:schaffen_software/constant/frequentWidget.dart';
import 'package:schaffen_software/utils/fire_auth.dart';
import 'package:schaffen_software/utils/validator.dart';


import 'SignUpPage.dart';

class SignUpPage extends StatefulWidget {


  @override
  SignUpPageState createState() {
    return new SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  double width = 400.0;
  double widthIcon = 200.0;
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _mobileNumberController= TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusMobile= FocusNode();

 
  //TextEditingController name = new TextEditingController();
  //TextEditingController email = new TextEditingController();
  //TextEditingController password = new TextEditingController();

  //FocusNode nameFocus = new FocusNode();
  //FocusNode emailFocus = new FocusNode();
  //FocusNode passwordFocus = new FocusNode();

  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        width = 190.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: ColorGlobal.whiteColor,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      ColorGlobal.colorPrimaryDark.withOpacity(0.8),
                      ColorGlobal.colorPrimary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
                child: AnimationBuildLogin(
                  size: size,
                  yOffset: size.height / 1.26,
                  color: ColorGlobal.whiteColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   /* Image.asset(
                      'assets/silver.png',
                      height: 120,
                      width: 120,
                      color: ColorGlobal.whiteColor,
                    ),*/
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 210.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Create Account !',
                      style: const TextStyle(
                        color: ColorGlobal.whiteColor,
                        fontSize: 24.0,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 22,
                  left: 22,
                  bottom: 22,
                  top: 270,
                ),
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                     Container(
                        child: TextFieldWidget(
                          hintText: 'Name',
                          obscureText: false,
                          prefixIconData: Icons.account_circle,
                          textEditingController: _nameTextController,
                          focusNode: _focusName,
                           validator:  (value) => Validator.validateName(
                            name: value,
                          ), 
                        ),
                      ),
                     
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFieldWidget(
                          hintText: 'Email',
                          obscureText: false,
                          prefixIconData: Icons.email,
                          textEditingController: _emailTextController,
                          focusNode: _focusEmail, 
                          validator: (value) => Validator.validateEmail(
                            email: value,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFieldWidget(
                          validator: (value) => Validator.validatePassword(
                            password: value,
                          ),
                          hintText: 'Password',
                          obscureText: true,
                          prefixIconData: Icons.lock,
                          focusNode: _focusPassword,
                          textEditingController: _passwordTextController,
                        ),
                      ),
                      
                      InkWell(
                        onTap: () async {
                             
                                        if (_registerFormKey.currentState!
                                            .validate()) {
                                          User? user = await FireAuth
                                              .registerUsingEmailPassword(
                                            name: _nameTextController.text,
                                           
                                            email: _emailTextController.text,
                                            password:
                                                _passwordTextController.text,
                                          );/*.then((value){
                                              
                                          });
    */                                   
                                          setState(() {
                                           // _isProcessing = false;
                                          });

                                          if (user != null) {
                                             FirebaseFirestore.instance.collection("users").doc(user.uid).set({"name":user.email});
                                      
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage(user: user),
                                              ),
                                              ModalRoute.withName('/'),
                                            );
                                          }
                                        }
                                      },
                        
                        
                        
                        /*() {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 400),
                                  child: SignUpPage()));
                        },*/
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: (30),
                            right: (8),
                            left: (8),
                            bottom: (20),
                          ),
                          height: (60.0),
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [
                                ColorGlobal.whiteColor,
                                ColorGlobal.whiteColor.withOpacity(0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ColorGlobal.colorPrimary.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                // changes position of shadow
                              ),
                            ],
                            border: Border.all(
                              width: 2,
                              color: ColorGlobal
                                  .colorPrimaryDark, //                   <--- border width here
                            ),
                            color: ColorGlobal.whiteColor,
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(
                                (22.0),
                              ),
                            ),
                          ),
                          child: Container(
//                        margin: EdgeInsets.only(left: (10)),
                            alignment: Alignment.center,
                            child: const Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                letterSpacing: 1,
                                color: ColorGlobal.colorPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 30),
        color: ColorGlobal.whiteColor,
        height: 70,
       
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(
                        context,
                        PageTransition(
                          child: Container(),
                          type: PageTransitionType.leftToRight,
                          duration: const Duration(milliseconds: 800),
                        ));
                    setState(() {
                      width = 400;
                      widthIcon = 0;
                    });
                  },
                  child: AnimatedContainer(
                    height: 65.0,
                    width: width,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.linear,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Have an Account",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    color:
                                        ColorGlobal.whiteColor.withOpacity(0.9),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Sign In",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    color:
                                        ColorGlobal.whiteColor.withOpacity(0.9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: ColorGlobal.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: const Radius.circular(40),
                        topRight: const Radius.circular(40),
                      ),
                      color: ColorGlobal.colorPrimaryDark,
                    ),
                  ),
                ),
                AnimatedContainer(
                  width: widthIcon,
                  duration: const Duration(seconds: 1),
                  curve: Curves.linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                     
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: FloatingActionButton.extended(
//
//          icon: Icon(Icons.update),
//          label: Text("Transform")),
    );
  }
}