import 'package:emmausapp/main.dart';
import 'package:emmausapp/presentation/widgets/profile_imagen_content.dart';
import 'package:emmausapp/presentation/widgets/profile_info_details.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: ProfileImageContent()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Oscar Mendez",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const ProfileInfoDetails(
                      title: "Curso",
                      description: "El Verbo de Dios",
                      icon: Icon(
                        Icons.book,
                        size: 30,
                        color: Colors.white,
                      )),
                  const ProfileInfoDetails(
                      title: "Iglesia local",
                      description: "Aldea El Batey",
                      icon: Icon(
                        Icons.church,
                        size: 30,
                        color: Colors.white,
                      )),
                  const ProfileInfoDetails(
                      title: "Telefono",
                      description: "98242108",
                      icon: Icon(
                        Icons.phone,
                        size: 30,
                        color: Colors.white,
                      )),
                  const ProfileInfoDetails(
                      title: "Correo",
                      description: "osc.mendez6@gmail.com",
                      icon: Icon(
                        Icons.email,
                        size: 30,
                        color: Colors.white,
                      )),
                  const ProfileInfoDetails(
                      title: "Fecha de nacimiento",
                      description: "06-Octubre",
                      icon: Icon(
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MainApp()));
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
