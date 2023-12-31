import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emmausapp/presentation/widgets/empty_state.dart';
import 'package:emmausapp/presentation/widgets/incourse_card_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InCourse extends StatelessWidget {
  const InCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    late Future<String> userEmail;
    late String courseName = "";
    late Map<String, dynamic> student = {
      "phone": "",
      "currentCourse": "",
      "church": "",
      "name": "",
      "dateOfBirth": "",
      "code": ""
    };

    late Map<String, dynamic> course = {
      "course": "",
      "levelName": "",
      "moduleName": "",
      "imagePath": "",
    };

    late Map<String, dynamic> sectionStudent = {
      "calification": "",
      "courseId": "",
      "revisorName": "",
      "status": "",
    };
    final db = FirebaseFirestore.instance;

    getCourseName(id) {
      db
          .collection("courses")
          .where("id", isEqualTo: id)
          .snapshots()
          .listen((event) {
        for (var doc in event.docs) {
          course = doc.data();
          courseName = course["course"];
        }
      });
    }

    getStudentSection(id) {
      db
          .collection("section-student")
          .where("idStudent", isEqualTo: id)
          .where("status", isEqualTo: "EN CURSO")
          .snapshots()
          .listen((event) {
        for (var doc in event.docs) {
          sectionStudent = doc.data();
          getCourseName(sectionStudent["courseId"]);
        }
      });
    }

    userEmail = prefs.then((SharedPreferences prefs) {
      var userEmail = prefs.getString('emailUser') ?? "";
      db
          .collection("students")
          .where("email", isEqualTo: userEmail)
          .snapshots()
          .listen((event) async {
        for (var doc in event.docs) {
          student = doc.data();
          getStudentSection(student["id"]);
          getCourseName(student["currentCourse"]);
        }
      });
      return userEmail;
    });

    final Future<String> getUserEmail = Future<String>.delayed(
      const Duration(seconds: 1),
      () => userEmail,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 0, left: 0, bottom: 5),
      child: Column(children: [
        FutureBuilder(
            future: getUserEmail,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                if (sectionStudent["status"] != "") {
                  return InCourseCardDetails(
                    course: courseName,
                    revisor: sectionStudent["revisorName"],
                    status: sectionStudent["status"],
                    note: sectionStudent["calification"].toString(),
                    module: course["moduleName"],
                    level: course["levelName"],
                    imagenPath: course["imagePath"].toString(),
                  );
                } else {
                  return const EmptyState(
                      imgPath: 'assets/images/empty.svg',
                      message: 'No estas cursando ahora');
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const EmptyState(
                    imgPath: 'assets/images/wifi_signal.svg',
                    message:
                        'Upss! lo sentimos.\nOcurrio algun error en la carga de datos\n intenta mas tarde');
              }
            })
      ]),
    );
  }
}
