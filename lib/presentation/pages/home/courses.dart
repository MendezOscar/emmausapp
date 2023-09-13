import 'package:emmausapp/presentation/pages/course/all.dart';
import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Column(
            children: [
              Container(
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 51, 141, 58)),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: const Color.fromARGB(255, 40, 119, 46),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelColor: Colors.white,
                  dividerColor: Colors.black,
                  tabs: const [
                    Tab(
                      child: Text("Todo"),
                    ),
                    Tab(
                      child: Text("En Curso"),
                    ),
                    Tab(
                      child: Text("Terminado"),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  AllCourses(),
                  MyTabOne(),
                  MyTabOne(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTabOne extends StatelessWidget {
  const MyTabOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "This is Tab One",
      style: TextStyle(fontSize: 20),
    ));
  }
}
