import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vdosecshare/reusable_text_field/text_field.dart';
import 'package:vdosecshare/screen/signInScreen.dart';
import 'package:vdosecshare/utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var passwordTextController = new TextEditingController();
  var emailTextController = new TextEditingController();
  var userNameTextController = new TextEditingController();
  var mobileNumberTextController = new TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(30, 120, 30, 10),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    userNameTextController),
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Enter EmailId", Icons.mail_outline, false,
                    emailTextController),
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    passwordTextController),
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Enter MobileNumber", Icons.call, false,
                    mobileNumberTextController),
                const SizedBox(
                  height: 40,
                ),
                OutlinedButton(
                    child: Text("Register", style: TextStyle(fontSize: 23)),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(20),
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    onPressed: (){
                        auth();
                        database();
                    })
              ],
            ),
          ))),
    );
  }

  void insertData(
      String UserName, String EmailId, String Password, String MobileNumber) {
    databaseRef.child("path").set({
      "UserName": UserName,
      "EmailId": EmailId,
      "Password": Password,
      "MobileNumber": MobileNumber,
    });
    userNameTextController.clear();
    emailTextController.clear();
    passwordTextController.clear();
    mobileNumberTextController.clear();
  }

  database() async {
    if (userNameTextController.text.isNotEmpty &&
        emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        mobileNumberTextController.text.isNotEmpty)
      insertData(userNameTextController.text, emailTextController.text,
          passwordTextController.text, mobileNumberTextController.text);
  }

  auth() async {
     FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text, password: passwordTextController.text);
     {
       print("Created New Account");
       Navigator.push(
           context, MaterialPageRoute(builder: (context) => SigninScreen()));
     }
  }
}
