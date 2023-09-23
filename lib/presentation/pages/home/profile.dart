import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emmausapp/main.dart';
import 'package:emmausapp/presentation/widgets/profile_imagen_content.dart';
import 'package:emmausapp/presentation/widgets/profile_info_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    late Future<String> userEmail;
    late String courseName = "";
    late Map<String, dynamic> course = {
      "course": "",
      "levelName": "",
      "moduleName": "",
      "imagePath": "",
    };
    late Map<String, dynamic> student = {
      "phone": "",
      "currentCourse": "",
      "church": "",
      "name": "",
      "dateOfBirth": "",
      "code": ""
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

    userEmail = prefs.then((SharedPreferences prefs) {
      var userEmail = prefs.getString('emailUser') ?? "";
      db
          .collection("students")
          .where("email", isEqualTo: userEmail)
          .snapshots()
          .listen((event) async {
        for (var doc in event.docs) {
          student = doc.data();
          getCourseName(student["currentCourse"]);
          await prefs.setString('idlUser', student["id"]);
        }
      });
      return userEmail;
    });

    final Future<String> getUserEmail = Future<String>.delayed(
      const Duration(seconds: 1),
      () => userEmail,
    );

    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: ProfileImageContent()),
          Expanded(
            flex: 3,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: getUserEmail,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(
                              student["name"],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                            Text(
                              student["code"],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            ProfileInfoDetails(
                                title: "Curso",
                                description: courseName == ""
                                    ? "No estas cursando ahora"
                                    : courseName,
                                icon: const Icon(
                                  Icons.book,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            ProfileInfoDetails(
                                title: "Iglesia local",
                                description: student["church"],
                                icon: const Icon(
                                  Icons.church,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            ProfileInfoDetails(
                                title: "Telefono",
                                description: student["phone"],
                                icon: const Icon(
                                  Icons.phone,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            ProfileInfoDetails(
                                title: "Correo",
                                description: snapshot.data ?? "",
                                icon: const Icon(
                                  Icons.email,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            ProfileInfoDetails(
                                title: "Fecha de nacimiento",
                                description: student["dateOfBirth"],
                                icon: const Icon(
                                  Icons.cake,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: FloatingActionButton.extended(
                                    backgroundColor: Colors.grey,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainApp()));
                                    },
                                    heroTag: 'btn6',
                                    elevation: 0,
                                    label: const Text("Cerrar sesión"),
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Container();
                      }
                    })),
          ),
        ],
      ),
    );
  }
}
