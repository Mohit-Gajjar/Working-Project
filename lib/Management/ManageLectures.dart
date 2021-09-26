import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Create%20Pages/CreateLectures.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Management/Profiles/LecturesProfile.dart';
import 'package:flutter/material.dart';

class ManageLectures extends StatefulWidget {
  const ManageLectures({Key? key}) : super(key: key);

  @override
  _ManageLecturesState createState() => _ManageLecturesState();
}

class _ManageLecturesState extends State<ManageLectures> {
  Stream? lectureStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Widget lectureList() => StreamBuilder(
      stream: lectureStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return LectureTile(snapshot.data.docs[index]["Subject_Name"],
                      snapshot.data.docs[index]["Lecture_Name"]);
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });
  @override
  void initState() {
    getLectures();
    super.initState();
  }

  getLectures() {
    databaseMethods.getLectures("Computer").then((val) {
      lectureStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: text("Manage Lectures", 16),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateLectures()));
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: textColor,
                    size: 30,
                  ))
            ]),
        body: Container(
          child: lectureList(),
        ));
  }
}

class LectureTile extends StatelessWidget {
  final String subject;
  final String name;
  LectureTile(this.subject, this.name);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LecturesProfile()));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Center(
            child: text(name[0].toUpperCase(), 16),
          ),
        ),
        title: text(name, 16),
        subtitle: text(subject, 14),
      ),
    );
  }
}
