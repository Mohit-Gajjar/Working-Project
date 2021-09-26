import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

class CreateTeacher extends StatefulWidget {
  const CreateTeacher({Key? key}) : super(key: key);

  @override
  _CreateTeacherState createState() => _CreateTeacherState();
}

class _CreateTeacherState extends State<CreateTeacher> {
  String postfix = "@asmsgroup.edu.in";
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController subjectController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  String? _chosenValue;
  final snackBar = SnackBar(content: Text('Teacher Created Sucessfully'));
  createTeacher() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> createdTeacherInfo = {
        "name": usernameController.text,
        "email": emailController.text,
        "LoginEmail": usernameController.text.replaceAll(" ", "").toLowerCase() + postfix,
        "contact": contactController.text,
        "assigned_subject": subjectController.text,
        "assigned_semester": "HardCoded Value = sem5",
        "assigned_department": _chosenValue,
        "role": "Teacher",
      };
      AuthMethod()
          .createTeacherWithEmailPassword(
              usernameController.text.replaceAll(" ", "").toLowerCase() + postfix, passwordController.text)
          .then((value) {
        DatabaseMethods().createTeacherData(createdTeacherInfo);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(value.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: text("Add Teacher", 16),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      contactController.clear();
                      passwordController.clear();
                      emailController.clear();
                      subjectController.clear();
                      usernameController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: textColor,
                    size: 30,
                  ))
            ]),
        backgroundColor: backColor,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    inputFieldUsername("Enter Username", Icons.person, context,
                        usernameController),
                    SizedBox(
                      height: 20,
                    ),
                    inputFieldContact(
                        "Enter Contact", Icons.phone, context, contactController),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: textColor),
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Icon(Icons.business, color: textColor),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              dropdownColor: btnColor,
                              value: _chosenValue,
                              //elevation: 5,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: textColor,
                              items: <String>[
                                'Chemical',
                                'Computer',
                                'Mechinical',
                                'Civil',
                                'BioMedical',
                                'Enviroment',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: text(value, 15));
                              }).toList(),
                              hint: text("Department", 16),
                              onChanged: (String? value) {
                                setState(() {
                                  _chosenValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    inputFieldemail(
                        "Enter Email", Icons.mail, context, emailController),
                    SizedBox(
                      height: 20,
                    ),
                    inputFieldPass("Enter Password", Icons.vpn_key, context,
                        passwordController),
                    SizedBox(
                      height: 20,
                    ),
                    text(
                        "Login Email: " +
                            usernameController.text.replaceAll(" ", "").toLowerCase() +
                            postfix,
                        16),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty &&
                              contactController.text.isNotEmpty &&
                              emailController.text.isNotEmpty) {
                            setState(() {
                              createTeacher();
                              print("Teacher Is Added");
                              contactController.clear();
                              passwordController.clear();
                              emailController.clear();

                              usernameController.clear();
                            });
                          }
                        },
                        child: btn("Create", 100)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
