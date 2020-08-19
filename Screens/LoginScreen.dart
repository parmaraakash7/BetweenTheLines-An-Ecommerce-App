import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_beautiful_popup/main.dart';
import "User.dart";
import "../Pages/CurrentUser.dart";

class LoginApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class Consts {

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class CustomDialog extends StatelessWidget {
  final String title, description,description2, buttonText;
  final String image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.description2,
    @required this.buttonText,
    this.image,
  });

  dialogContent(BuildContext context) {
  return Stack(
    children: <Widget>[
      //...bottom card part,
      Container(
  padding: EdgeInsets.only(
    top: Consts.avatarRadius + Consts.padding,
    bottom: Consts.padding,
    left: Consts.padding,
    right: Consts.padding,
  ),
  margin: EdgeInsets.only(top: Consts.avatarRadius),
  decoration: new BoxDecoration(
    color: Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(Consts.padding),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10.0,
        offset: const Offset(0.0, 10.0),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min, // To make the card compact
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(height: 16.0),
      Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      SizedBox(height: 16.0),
      Text(
        description2,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      SizedBox(height: 24.0),
      Align(
        alignment: Alignment.bottomRight,
        child: FlatButton(
          onPressed: () {
            //Navigator.of(context).pop(); // To close the dialog
            //String name,email;
            //name = description.substring(0,);
            User user = new User(0,description,description2,image);
            Navigator.pushNamed(context, '/homepage',arguments:user);
          },
          child: Text(buttonText),
        ),
      ),
      /*FlatButton(
        child : Text(buttonText),
        onPressed: () {
            Navigator.of(context).pop(); // To close the dialog
          },
      ),*/
    ],
  ),
),

      //...top circlular image part,
      Positioned(
  left: Consts.padding,
  right: Consts.padding,
  child: CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 64.0,
    child: ClipOval(
        child: Image.network(
          image
        ),
    ),
  ),
),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

class _LoginPageState extends State<LoginApp> {

  // f45d27
  // f5851f
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  
  Future<FirebaseUser> _signIn() async
  {

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    print("User Photo = ${user.photoUrl}");
    print("User Email = ${user.email}");
    CurrentUser.photoUrl=user.photoUrl;
    var url=user.photoUrl;
    var name,email;
    name = user.displayName;
    email = user.email;
    showDialog(
    context: context,
    barrierDismissible : false,
    builder: (BuildContext context) => CustomDialog(
        title: "Signed in as",
        description:name,
        description2:email,
        buttonText: "Next ",
        image : url,
      ),  
    );
    return user;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  void _signOut()
  {
    googleSignIn.signOut();
    print("user Signed out..");
  }

  callSuccess()
  {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context)
          .modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height -  80,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color(0xFF1BC0C5),
                )
              ],
            ),
          ),
        );
      });
  }

Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () =>_signIn().then((user)=>print("Hi")).catchError((e)=>print(e)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      highlightElevation: 5,
      borderSide: BorderSide(color: Colors.grey),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("Assets/Images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }




  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('OR'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            splashColor : Color(0xfff79c4f),
            onTap: () {
              print("Register clicked");
              Navigator.pushNamed(context, '/signup_screen');
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xFF262AAA),
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF262AAA),
                    Color(0xFF262AAA),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 32,
                          right: 32
                        ),
                        child: Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                      top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5
                        )
                      ]
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.email,
                            color: Colors.grey,
                        ),
                          hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextField(
                      obscureText : true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.vpn_key,
                          color: Colors.grey,
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16, right: 32
                      ),
                      child: InkWell(
                        splashColor : Colors.grey,
                        onTap : (){print("Forgot Password.");},
                        child : Text('Forgot Password ?',
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      )),
                    ),
                  ),
                  Container(height : 10.0),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width/1.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF262AAA),
                          Color(0xFF262AAA),
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50)
                      )
                    ),
                    child: InkWell(
                      onTap : (){
                        print("Login tapped..");
                        _signOut();
                        },
                      child : Center(
                      child: Text('Login'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize : 20.0,
                        ),
                      ),
                    )),
                  ),
                  _divider(),
                  _signInButton(),
                  _createAccountLabel(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
