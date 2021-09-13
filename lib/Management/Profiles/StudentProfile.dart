import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  final String? enroll;
  const StudentProfile({Key? key, required this.enroll}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  Timestamp? timeOfCreation;
  Stream? studentInfoStream;
  Widget studentInfo() {
    return StreamBuilder(
        stream: studentInfoStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? StudentInfo(
                  snapshot.data!.docs[0]["StudentName"],
                  snapshot.data!.docs[0]["StudentContactNo"],
                  snapshot.data!.docs[0]["StudentEmail"],
                  snapshot.data!.docs[0]["StudentEnrollmentNo"],
                  snapshot.data!.docs[0]["DateOfBirth"],
                  snapshot.data!.docs[0]["ParentsContactNo"],
                  snapshot.data!.docs[0]["Gender"],
                  snapshot.data!.docs[0]["ParentsEmail"],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  void initState() {
    getStudentInfo();
    super.initState();
  }

  getStudentInfo() {
    DatabaseMethods()
        .getStudentByEnroll(widget.enroll.toString())
        .then((value) {
      studentInfoStream = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: text("Student Info", 16),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: studentInfo(),
      ),
    );
  }
}

// ignore: must_be_immutable
class StudentInfo extends StatelessWidget {
  StudentInfo(
    this.studentName,
    this.studentContact,
    this.studentEmail,
    this.studentEnrollment,
    this.dob,
    this.parentsNo,
    this.gender,
    this.parentEmail,
  );

  final String studentName;
  final String studentContact;
  final String studentEmail;
  final String studentEnrollment;
  final String dob;
  final String gender;
  final String parentsNo;
  final String parentEmail;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: text("Name", 14),
          subtitle: text(studentName, 16),
        ),
        ListTile(
          title: text("Student Contact No", 14),
          subtitle: text(studentContact, 16),
        ),
        ListTile(
          title: text("Student Email", 14),
          subtitle: text(studentEmail, 16),
        ),
        ListTile(
          title: text("Student Enrollment No", 14),
          subtitle: text(studentEnrollment, 16),
        ),
        ListTile(
          title: text("Date Of Birth", 14),
          subtitle: text(dob, 16),
        ),
        ListTile(
          title: text("Gender", 14),
          subtitle: text(gender, 16),
        ),
        ListTile(
          title: text("Parents No", 14),
          subtitle: text(parentsNo, 16),
        ),
        ListTile(
          title: text("Parents Email", 14),
          subtitle: text(parentEmail, 16),
        ),
      ],
    );
  }
}
