import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

class LecturesProfile extends StatefulWidget {
  const LecturesProfile({Key? key}) : super(key: key);

  @override
  _LecturesProfileState createState() => _LecturesProfileState();
}

class _LecturesProfileState extends State<LecturesProfile> {
  Stream? lecturesStream;
  @override
  void initState() {
    getLectureInfo();
    super.initState();
  }

  getLectureInfo() {
    DatabaseMethods().getLecturesByDept("Computer").then((value) {
      lecturesStream = value;
      setState(() {});
    });
  }

  Widget lectureInfo() {
    return StreamBuilder(
        stream: lecturesStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? LecturesInfoTile(
                  snapshot.data!.docs[0]["Date"].toString(),
                  snapshot.data!.docs[0]["From_Time"].toString(),
                  snapshot.data!.docs[0]["Lecture_Name"],
                  snapshot.data!.docs[0]["Subject_Name"],
                  snapshot.data!.docs[0]["To_Time"].toString(),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: text("Lectures Info", 16),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      body: Container(
        child: lectureInfo(),
      ),
    );
  }
}

class LecturesInfoTile extends StatelessWidget {
  LecturesInfoTile(this.date, this.from_time, this.lecture_name,
      this.subject_name, this.to_time);

  final String date;
  // ignore: non_constant_identifier_names
  final String from_time;
  // ignore: non_constant_identifier_names
  final String lecture_name;
  // ignore: non_constant_identifier_names
  final String subject_name;
  // ignore: non_constant_identifier_names
  final String to_time;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: text("Lecture Name", 14),
          subtitle: text(lecture_name, 16),
        ),
        ListTile(
          title: text("Subject Name:", 14),
          subtitle: text(subject_name, 16),
        ),
        ListTile(
          title: text("From:", 14),
          subtitle: text(from_time, 16),
        ),
        ListTile(
          title: text("To:", 14),
          subtitle: text(to_time, 16),
        ),
        ListTile(
          title: text("Date:", 14),
          subtitle: text(date, 16),
        ),
      ],
    );
  }
}
