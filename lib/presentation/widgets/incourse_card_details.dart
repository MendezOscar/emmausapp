import 'package:flutter/material.dart';

class InCourseCardDetails extends StatelessWidget {
  final String course;
  final String revisor;
  final String status;
  final String note;
  final String module;
  final String level;
  final String imagenPath;

  const InCourseCardDetails({
    required this.course,
    required this.revisor,
    required this.status,
    required this.note,
    required this.module,
    required this.level,
    required this.imagenPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color.fromARGB(255, 8, 41, 68),
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/$imagenPath.png',
                  width: 120,
                  height: 120,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Curso",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                course,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    maxLines: 3,
                    "Nivel: ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    level,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    maxLines: 3,
                    "Modulo: ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    module.length > 19 ? module.substring(0, 19) : "",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    maxLines: 3,
                    "Revisor: ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    maxLines: 3,
                    revisor,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    maxLines: 3,
                    "Estado: ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    maxLines: 3,
                    status,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    maxLines: 3,
                    "Nota: ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    maxLines: 3,
                    note,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
