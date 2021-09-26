import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Responsive.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/Management/ManageLectures.dart';
import 'package:asms/Management/ManageStudent.dart';
import 'package:asms/Management/ManageSubject.dart';
import 'package:asms/Management/ManageTeacher.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:asms/University/ManageUniversity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AdminHome extends StatefulWidget {
  AdminHome({
    Key? key,
  }) : super(key: key);
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // ignore: non_constant_identifier_names
  int student_counter = 0;
  // ignore: non_constant_identifier_names
  int teacher_counter = 0;
  // ignore: non_constant_identifier_names
  int subject_counter = 0;
  // ignore: non_constant_identifier_names
  int lecture_counter = 0;

  int onGoingSem = 0;
  String department = 'NULL';
  String name = " ";
  String email = " ";
  getCount() async {
    name = (await HelperFunctions.getAdminNameSharedPreference())!;
    email = (await HelperFunctions.getAdminEmailSharedPreference())!;
    student_counter = await DatabaseMethods().noOfStudent();
    teacher_counter = await DatabaseMethods().noOfTeachers();
    subject_counter = await DatabaseMethods().noOfSubjects();
    lecture_counter = await DatabaseMethods().noOfLectures();
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCount();
    getUniversityInfo();
  }

  getUniversityInfo() {
    //TODO Hardcoded  university
    DatabaseMethods().getUniversity("Computer").then((value) {
      universityStream = value;
    });
  }

  Stream? universityStream;
  Widget universityInfo() {
    return StreamBuilder(
        stream: universityStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? UniversityTile(
                  snapshot.data!.docs[0]["Course_Name"],
                  snapshot.data!.docs[0]["Department_Name"],
                  snapshot.data!.docs[0]["Semester"],
                  snapshot.data!.docs[0]["University_Name"],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: backColor,
        body: MakeResponsive(
          desktop: Row(
            children: [
              Expanded(
                  flex: _size.width > 1340 ? 2 : 4,
                  child: SafeArea(
                    child: Container(
                      color: backColor,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                                radius: 20,
                                child: Center(
                                  child: text(name[0].toUpperCase(), 18),
                                )),
                            title: text(name, 16),
                            // subtitle: text(email, 12),
                          ),
                          ListTile(
                            title: text("Logout", 16),
                            leading: const Icon(
                              Icons.logout,
                              color: textColor,
                            ),
                            onTap: () {
                              setState(() {
                                AuthMethod().signOut();
                                HelperFunctions
                                    .saveAdminLoggedInSharedPreference(false);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LevelPage()));
                              });
                            },
                          ),
                          ListTile(
                            title: text("Edit University", 16),
                            leading: const Icon(
                              Icons.business,
                              color: textColor,
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ManageUniversity())),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: _size.width > 1340 ? 3 : 5,
                  child: Container(
                    color: btnColor,
                    child: Column(
                      children: [],
                    ),
                  )),
              Expanded(
                  flex: _size.width > 1340 ? 8 : 10,
                  child: Container(
                    width: _size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 40),
                              color: backColor,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TotalCard(
                                      counter: student_counter,
                                      title: 'Total Students',
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    TotalCard(
                                      counter: teacher_counter,
                                      title: 'Total Teachers',
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    TotalCard(
                                      counter: subject_counter,
                                      title: 'Total Subjects',
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    TotalCard(
                                      counter: lecture_counter,
                                      title: 'Total Lectures',
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(width: 40),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 40),
                                      text("College Information:", 20),
                                      universityInfo(),
                                    ],
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                      child: Container(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ManageStudent()));
                                                  },
                                                  child: gridTile(
                                                      "Manage Student",
                                                      "assets/1.png",
                                                      context)),
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ManageTeacher()));
                                                  },
                                                  child: gridTile(
                                                      "Manage Teacher",
                                                      "assets/1.png",
                                                      context)),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ManageSubject()));
                                                  },
                                                  child: gridTile(
                                                      "Manage Subject",
                                                      "assets/1.png",
                                                      context)),
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ManageLectures()));
                                                  },
                                                  child: gridTile(
                                                      "Manage Lecture",
                                                      "assets/1.png",
                                                      context)),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {},
                                                  child: gridTile(
                                                      "Student`s Complain",
                                                      "assets/1.png",
                                                      context)),
                                              GestureDetector(
                                                  onTap: () {},
                                                  child: gridTile(
                                                      "Teacher`s Complain",
                                                      "assets/1.png",
                                                      context)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
          mobile: Container(),
          tablet: Container(),
        ));
  }
}

// ignore: must_be_immutable
class TotalCard extends StatelessWidget {
  int counter;
  String title;
  TotalCard({
    required this.counter,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: btnColor),
        child: Center(
          child: ListTile(
              title: text(counter.toString(), 30), subtitle: text(title, 16)),
        ));
  }
}

// ignore: must_be_immutable
class UniversityTile extends StatelessWidget {
  UniversityTile(
      this.courseName, this.departmentName, this.semester, this.universityName);

  final String departmentName;
  final String courseName;
  final String semester;
  final String universityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
          // color: Colors.amber,
          borderRadius: BorderRadius.circular(18)),
      child: ListView(
        children: [
          ListTile(
            title: text("University Name:", 13),
            subtitle: (text(universityName, 16)),
          ),
          ListTile(
            title: text("Department:", 13),
            subtitle: (text(departmentName, 16)),
          ),
          ListTile(
            title: text("Semester:", 13),
            subtitle: (text(semester, 16)),
          ),
          ListTile(
            title: text("Course:", 13),
            subtitle: (text(courseName, 16)),
          ),
        ],
      ),
    );
  }
}
