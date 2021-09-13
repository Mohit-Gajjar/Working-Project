import 'package:asms/Admin/AdminHome.dart';
import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/ForgotPassword.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  QuerySnapshot? snapshot;

  signIn() {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveAdminEmailSharedPreference(emailController.text);
      DatabaseMethods().getAdminBy(emailController.text).then((val) {
        snapshot = val;
        HelperFunctions.saveAdminNameSharedPreference(
            snapshot!.docs[0]["username"]);
      });
      AuthMethod()
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveAdminLoggedInSharedPreference(true);
          print("AdminLogin Shared preff");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AdminHome()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                imageBox('assets/1.png', 300),
                text("Admin Login", 30),
                SizedBox(
                  height: 20,
                ),
                inputFieldemail(
                    "Enter Email", Icons.person, context, emailController),
                SizedBox(
                  height: 20,
                ),
                inputFieldPass("Enter Password", Icons.vpn_key, context,
                    passwordController),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        setState(() {
                          signIn();
                        });
                      }
                    },
                    child: btn("Login", 100)),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPass())),
                          child: text_underline("Forgot Password?", 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
