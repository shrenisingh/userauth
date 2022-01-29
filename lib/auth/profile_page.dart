import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schaffen_software/auth/login.dart';
import 'package:schaffen_software/utils/fire_auth.dart';
import 'package:schaffen_software/widget/appbar_widget.dart';
import 'package:schaffen_software/widget/button_widget.dart';
import 'package:schaffen_software/themes.dart';
import 'package:schaffen_software/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;
    return  Scaffold(
      appBar:AppBar(
    leading: BackButton(),
    backgroundColor: Color(0xFFFFC0CB),
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;

            final switcher = ThemeSwitcher.of(context);
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileWidget(
                imagePath: 'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
                onClicked: () {
                /*  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );*/
                },
              ),
              SizedBox(height: 16.0),
            Text(
              '${_currentUser.displayName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              
            ),
            SizedBox(height: 16.0),
            Text(
              ' ${_currentUser.email}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
           
            SizedBox(height: 16.0),
          /*  _isSendingVerification
                ? CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isSendingVerification = true;
                          });
                          await _currentUser.sendEmailVerification();
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: Text('Verify email'),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          User? user = await FireAuth.refreshUser(_currentUser);

                          if (user != null) {
                            setState(() {
                              _currentUser = user;
                            });
                          }
                        },
                      ),
                    ],
                  ),*/
            SizedBox(height: 16.0),
           
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    backgroundColor: Color(0xFFFFC0CB),
                    child: Icon(Icons.logout),
                   
                  ),
    );
  }
  /* Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
         /* Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          ),*/
        /*  Text(
            user.mobile,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),*/
        ],
      );*/

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Search Friends',
        onClicked: () {},
      );
}