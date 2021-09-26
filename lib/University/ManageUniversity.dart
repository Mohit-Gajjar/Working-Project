import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

class ManageUniversity extends StatefulWidget {
  const ManageUniversity({Key? key}) : super(key: key);

  @override
  _ManageUniversityState createState() => _ManageUniversityState();
}

class _ManageUniversityState extends State<ManageUniversity> {
  final formKey = GlobalKey<FormState>();
  String? _chosenDepartment;
  String? _chosenCourse;

  TextEditingController universityNameController = new TextEditingController();
  TextEditingController semController = new TextEditingController();
  TextEditingController courseController = new TextEditingController();
  TextEditingController departmentController = new TextEditingController();
  final snackBar = SnackBar(content: Text('University Edited Sucessfully'));
  createUniversity() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> createdUniversityMap = {
        "University_Name": universityNameController.text,
        "Department_Name": _chosenDepartment,
        "Semester": semController.text,
        "Course_Name": _chosenCourse,
        "key": "University"
      };
      DatabaseMethods().createUniversity(createdUniversityMap);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool selectedDepartment = false;
  bool selectedCourse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: text("Manage University", 16),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  inputFieldUsername("Enter University", Icons.business,
                      context, universityNameController),
                  SizedBox(height: 20),
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
                            value: _chosenDepartment,
                            elevation: 5,
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
                                _chosenDepartment = value;
                                selectedDepartment = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  inputFieldSem("Enter Semester",
                      Icons.business_center_outlined, context, semController),
                  SizedBox(height: 20),
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
                            value: _chosenCourse,
                            elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: textColor,
                            items: <String>['Diploma', 'Degree', 'MCA', 'BCA']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: text(value, 15));
                            }).toList(),
                            hint: text("Course", 16),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenCourse = value;
                                selectedCourse = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        if (universityNameController.text.isNotEmpty &&
                            semController.text.isNotEmpty &&
                            selectedCourse &&
                            selectedDepartment) {
                          setState(() {
                            createUniversity();
                          });
                        }
                      },
                      child: btn("Save", 100))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
