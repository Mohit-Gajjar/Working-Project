import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  createAdmin(userMap) {
    FirebaseFirestore.instance.collection("admin_users").add(userMap);
  }

  getAdminBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("admin_users")
        .where("email", isEqualTo: email)
        .get();
  }

  createStudentData(createdStudentInfo) async {
    return await FirebaseFirestore.instance
        .collection("student_users")
        .add(createdStudentInfo);
  }

  createUniversity(createdUniversityMap) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .add(createdUniversityMap);
  }

  getStudentBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("student_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
  }

  Future<Stream<QuerySnapshot>> getStudents() async {
    return FirebaseFirestore.instance
        .collection("student_users")
        .orderBy("TimeOfCreationOfStudent", descending: true)
        .where("role", isEqualTo: "Student")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getSubject(String department) async {
    return FirebaseFirestore.instance
        .collection("subjects")
        .where("Department", isEqualTo: department)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getLectures(String department) async {
    return FirebaseFirestore.instance
        .collection("lectures")
        .where("department", isEqualTo: department)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getTeachers() async {
    return FirebaseFirestore.instance
        .collection("teacher_users")
        .where("role", isEqualTo: "Teacher")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUniversity(String department) async {
    return FirebaseFirestore.instance
        .collection("University")
        .where("Department_Name", isEqualTo: department)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getStudentByEnroll(String enroll) async {
    return FirebaseFirestore.instance
        .collection("student_users")
        .where("StudentEnrollmentNo", isEqualTo: enroll)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getSubjectByCode(String code) async {
    return FirebaseFirestore.instance
        .collection("subjects")
        .where("Subject_Code", isEqualTo: code)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getLecturesByDept(String department) async {
    return FirebaseFirestore.instance
        .collection("lectures")
        .where("department", isEqualTo: department)
        .snapshots();
  }

  Future<int> noOfStudent() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("student_users").get();
    var count = snapshot.size;
    print("Number of Students " + count.toString());
    return count;
  }

  createTeacherData(createdTeacherInfo) async {
    return await FirebaseFirestore.instance
        .collection("teacher_users")
        .add(createdTeacherInfo);
  }

  getTeacherBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("teacher_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
  }

  createSubjectData(createdSubjectMap) async {
    return await FirebaseFirestore.instance
        .collection("subjects")
        .add(createdSubjectMap);
  }

  createLectureData(createdLecturesMap) async {
    return await FirebaseFirestore.instance
        .collection("lectures")
        .add(createdLecturesMap);
  }

  Future<int> noOfTeachers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("teacher_users").get();
    var count = snapshot.size;
    print("Number of Teachers " + count.toString());
    return count;
  }

  Future<int> noOfSubjects() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("subjects").get();
    var count = snapshot.size;
    print("Number of Subjects " + count.toString());
    return count;
  }

  Future<int> noOfLectures() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("lectures").get();
    var count = snapshot.size;
    print("Number of Lectures " + count.toString());
    return count;
  }
}
