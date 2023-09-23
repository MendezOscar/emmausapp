import 'package:emmausapp/presentation/pages/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyLoginState();
}

class _MyLoginState extends State<Login> {
  final myEmailControler = TextEditingController();
  final myPasswordControler = TextEditingController();

  @override
  void dispose() {
    myEmailControler.dispose();
    myPasswordControler.dispose();
    super.dispose();
  }

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
          TextField(
            controller: myEmailControler,
            style: const TextStyle(color: Colors.grey),
            decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 11, 44, 71),
                border: OutlineInputBorder(),
                hintText: 'Correo electrónico',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: myPasswordControler,
            obscureText: true,
            style: const TextStyle(color: Colors.grey),
            decoration: const InputDecoration(
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
                    _signInWithEmailAndPassword(context, myEmailControler.text,
                        myPasswordControler.text);
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
}

void _signInWithEmailAndPassword(context, email, password) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await prefs.setString('emailUser', email);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Home()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("No se encontro este usuario")),
        ),
      );
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Contrasena incorrecta")),
        ),
      );
    }
  }
}
