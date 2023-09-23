import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emmausapp/presentation/widgets/incourse_card_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InCourse extends StatelessWidget {
  const InCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    late Future<String> userId;
    late String courseName = "";
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

    userId = prefs.then((SharedPreferences prefs) {
      var userId = prefs.getString('idlUser') ?? "";
      db
          .collection("section-student")
          .where("idStudent", isEqualTo: userId)
          .where("status", isEqualTo: "EN CURSO")
          .snapshots()
          .listen((event) {
        for (var doc in event.docs) {
          sectionStudent = doc.data();
          getCourseName(sectionStudent["courseId"]);
        }
      });
      return userId;
    });

    final Future<String> getUserId = Future<String>.delayed(
      const Duration(seconds: 1),
      () => userId,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 0, left: 0, bottom: 5),
      child: Column(children: [
        FutureBuilder(
            future: getUserId,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return InCourseCardDetails(
                  course: courseName,
                  revisor: sectionStudent["revisorName"],
                  status: sectionStudent["status"],
                  note: sectionStudent["calification"].toString(),
                  module: course["moduleName"],
                  level: course["levelName"],
                );
              } else {
                return Container();
              }
            })
      ]),
    );
  }
}
