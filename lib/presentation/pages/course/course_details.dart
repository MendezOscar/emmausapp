import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  final String title;
  final String description;
  final String courseId;
  final int imagenPath;

  const CourseDetails(
      {required this.title,
      required this.description,
      required this.courseId,
      required this.imagenPath,
      super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> leesonsStream =
        FirebaseFirestore.instance.collection('lessons').snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 39, 82),
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/$imagenPath.png',
                      width: 200,
                      height: 300,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "LECCIONES QUE ESTUDIARÁS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: AutofillHints.creditCardName,
                      fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: leesonsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView(
                      shrinkWrap: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        if (data['courseId'] == courseId) {
                          return ListTile(
                            title: Text(
                              data['lesson'] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
