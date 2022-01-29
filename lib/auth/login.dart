import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:schaffen_software/animation/AnimationBuildLogin.dart';
import 'package:schaffen_software/auth/profile_page.dart';
import 'package:schaffen_software/constant/ColorGlobal.dart';
import 'package:schaffen_software/constant/TextField.dart';
import 'package:schaffen_software/utils/validator.dart';
import 'AuthButton.dart';
import 'package:schaffen_software/utils/fire_auth.dart';
import 'SignUpPage.dart';
class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return new LoginState();
  }
}
class LoginState extends State<Login> {
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  double width = 190.0;
  double widthIcon = 200.0;
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  //TextEditingController email = new TextEditingController();
  //TextEditingController password = new TextEditingController();

 // FocusNode emailFocus = new FocusNode();
  //FocusNode passwordFocus = new FocusNode();
    Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  getDisposeController() {
    _emailTextController.clear();
    _passwordTextController.clear();
    _focusEmail.unfocus();
    _focusPassword.unfocus();
  }

  @override
  void initState() {
    
    super.initState();
   // getDisposeController();
  }

  @override
  void dispose() {
   getDisposeController();
    
    super.dispose();
  }

  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
   // final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: ColorGlobal.whiteColor,
      body: SingleChildScrollView(
        child:  Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(),
                      height: size.height,
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          colors: [
                            ColorGlobal.colorPrimaryDark.withOpacity(0.7),
                            ColorGlobal.colorPrimary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOutQuad,
        //                top: keyboardOpen ? -size.height / 3.2 : 0.0,
                      child: AnimationBuildLogin(
                        size: size,
                        yOffset: size.height /1.36,
                        color: ColorGlobal.whiteColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         /* Image.asset(
                            'assets/silver.png',
                            height: 100,
                            width: 100,
                            color: ColorGlobal.whiteColor,
                          ),*/
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Welcome Back !',
                            style: TextStyle(
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
                      padding: EdgeInsets.only(
                        right: 22,
                        left: 22,
                        bottom: 22,
                        top: 270,
                      ),
                      child: /*FutureBuilder(
                        future: _initializeFirebase(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {*/
                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Form(
                                   key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                     
                          SizedBox(height: 8.0),
                         
                                      Container(
                                        child: TextFieldWidget(
                                          hintText: 'Email',
                                          obscureText: false,
                                          prefixIconData: Icons.mail_outline,
                                          textEditingController: _emailTextController,
                                          focusNode: _focusEmail,
                                          validator: (value) => Validator.validateEmail(
                                          email: value,
                                        ), 
                                        ),
                                      ),
                                      SizedBox(
                                        height: 22,
                                      ),
                                      Container(
                                        child: TextFieldWidget(
                                          validator: (value) => Validator.validatePassword(
                                          password: value,
                                        ),
                                          hintText: 'Password',
                                          obscureText: true,
                                          prefixIconData: Icons.lock,
                                          textEditingController: _passwordTextController,
                                          focusNode: _focusPassword,
                                        ),
                                      ),
                                      
                                      Container(
                                        alignment: Alignment.center,
                                        color: Colors.transparent,
                                        margin: EdgeInsets.only(
                                          top: 40,
                                          right: (8),
                                          left: (8),
                                          bottom: (20),
                                        ),
                                        child: AuthButton(onClick: () async {
                                                          _focusEmail.unfocus();
                                                          _focusPassword.unfocus();
                                    
                                                          if (_formKey.currentState!
                                                              .validate()) {
                                                           setState(() {
                                                             // _isProcessing = true;
                                                           });
                                    
                                                            User? user = await FireAuth
                                                                .signInUsingEmailPassword(
                                                              email: _emailTextController.text,
                                                              password:
                                                                  _passwordTextController.text,
                                                            );
                                    
                                                            setState(() {
                                                             // _isProcessing = false;
                                                            });
                                    
                                                            if (user != null) {
                                                              Navigator.of(context)
                                                                  .pushReplacement(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ProfilePage(user: user),
                                                                ),
                                                              );
                                                            }
                                                          }
                                                        },),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      /*  }
                        return Center(
              child: CircularProgressIndicator(),
            );
                        }
                      ),*/
                    )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Container(
        color: ColorGlobal.whiteColor,
        height: 70,
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AnimatedContainer(
                  width: widthIcon,
                  duration: Duration(seconds: 1),
                  curve: Curves.linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                     
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    getDisposeController();
                    Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 800),
                                child: SignUpPage()))
                        .then((value) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        setState(() {
                          width = 190;
                          widthIcon = 200;
                        });
                      });
                    });
                    setState(() {
                      width = 500.0;
                      widthIcon = 0;
                    });
                  },
                  child: AnimatedContainer(
                    height: 65.0,
                    width: width,
                    duration: Duration(milliseconds: 1000),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ColorGlobal.whiteColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Not Yet Register ?",
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
                              SizedBox(height: 5),
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Sign Up",
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
                      ],
                    ),
                    curve: Curves.linear,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      color: ColorGlobal.colorPrimaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
