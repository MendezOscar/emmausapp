import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emmausapp/presentation/widgets/course_description.dart';
import 'package:flutter/material.dart';

class LevelDetails extends StatelessWidget {
  final String title;
  final String subTitle;

  const LevelDetails({
    required this.title,
    required this.subTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> modulesStream =
        FirebaseFirestore.instance.collection('modules').snapshots();
    final Stream<QuerySnapshot> courseStream =
        FirebaseFirestore.instance.collection('courses').snapshots();
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(subTitle,
          style: const TextStyle(color: Colors.white, fontSize: 12)),
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: modulesStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  if (data['levelId'] == title) {
                    return ExpansionTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(data['module'],
                            style: const TextStyle(color: Colors.white)),
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: courseStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return ListView(
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot documentCourse) {
                                    Map<String, dynamic> dataCourse =
                                        documentCourse.data()!
                                            as Map<String, dynamic>;
                                    if (dataCourse['moduleId'] == data['id']) {
                                      return CourseDescription(
                                        title: dataCourse['course'],
                                        description: dataCourse['description'],
                                        imagenPath: dataCourse['imagePath'],
                                        courseId: dataCourse['id'],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList());
                            },
                          )
                        ]);
                  } else {
                    return Container();
                  }
                }).toList(),
              );
            })
      ],
    );
  }
}
