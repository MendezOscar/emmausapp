import 'package:emmausapp/presentation/pages/course/course_details.dart';
import 'package:flutter/material.dart';

class CourseDescription extends StatelessWidget {
  final String title;
  final String description;
  final String imagenPath;
  final String courseId;

  const CourseDescription({
    required this.title,
    required this.description,
    required this.imagenPath,
    required this.courseId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF0E497A),
      child: Row(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/$imagenPath',
                width: 150,
                height: 150,
              )
            ],
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  maxLines: 3,
                  description.length > 60
                      ? '${description.substring(0, 60)}...'
                      : description,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                      backgroundColor: const Color.fromARGB(255, 40, 119, 46)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CourseDetails(
                              title: title,
                              description: description,
                              courseId: courseId,
                            )));
                  },
                  child: const Text('Ver mayor informacion'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
