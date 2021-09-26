import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Create%20Pages/CreateSubjects.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Management/Profiles/SubjectProfile.dart';
import 'package:flutter/material.dart';

class ManageSubject extends StatefulWidget {
  const ManageSubject({Key? key}) : super(key: key);

  @override
  _ManageSubjectState createState() => _ManageSubjectState();
}

class _ManageSubjectState extends State<ManageSubject> {
  Stream? studentListStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Widget subjectList() => StreamBuilder(
      stream: studentListStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return SubjectTile(snapshot.data.docs[index]["Subject_Code"],
                      snapshot.data.docs[index]["Subject_Name"]);
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });
  @override
  void initState() {
    getSubjects();
    super.initState();
  }

  getSubjects() {
    databaseMethods.getSubject("Computer").then((val) {
      studentListStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: text("Manage Subject", 16),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateSubject()));
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: textColor,
                  size: 30,
                ))
          ]),
      body: Container(
        child: subjectList(),
      ),
    );
  }
}

class SubjectTile extends StatelessWidget {
  final String code;
  final String name;
  SubjectTile(this.code, this.name);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubjectProfile(
                      code: code,
                    )));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Center(
            child: text(name[0].toUpperCase(), 16),
          ),
        ),
        title: text(name, 16),
        subtitle: text(code, 14),
      ),
    );
  }
}
