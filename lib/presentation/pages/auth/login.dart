import 'package:emmausapp/presentation/pages/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo_login.png'),
          const SizedBox(
            height: 10,
          ),
          const TextField(
            style: TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 11, 44, 71),
                border: OutlineInputBorder(),
                hintText: 'Correo electrónico',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextField(
            style: TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 11, 44, 71),
                border: OutlineInputBorder(),
                hintText: 'Contraseña',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: const Color.fromARGB(255, 40, 119, 46)),
                  onPressed: () async {
                    _signInWithEmailAndPassword(context);
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "¿Se te olvido tu contraseña?",
            style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 40, 119, 46),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "¿No tienes una cuenta?",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Regístrate",
            style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 40, 119, 46),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  void _signInWithEmailAndPassword(context) async {
    try {
      var user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "",
        password: "",
      ))
          .user;

      if (user != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Home()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
