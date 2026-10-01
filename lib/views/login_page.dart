import 'package:flutter/material.dart';

import '../models/data.dart';
import '../root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  void tampilPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  void login() {
    String username = usernameC.text.trim();
    String password = passwordC.text.trim();

    // Validasi input kosong
    if (username.isEmpty || password.isEmpty) {
      tampilPesan('Username dan password tidak boleh kosong');
      return;
    }

    // Cek data login
    if (username == account.username && password == account.password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Root(username: username)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Login Gagal. Username atau Password Salah"),
        ),
      );
    }
  }

  @override
  void dispose() {
    usernameC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.network(
                  "https://play-lh.googleusercontent.com/bB_cyOTbQfFmV4IaeqTIFJVc1Wm4UdQwQai8GjthG4uaXrTHNZTKsMtg9_9058GeZGLgoJzIasYYdFkSvdyQ",
                  height: 200,
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 8),
                const Text('Selamat Datang di Uniqlo'),
                const SizedBox(height: 4),
                const Text('Selamat Berbelanja'),
                const SizedBox(height: 24),
                TextField(
                  controller: usernameC,
                  decoration: InputDecoration(
                    hintText: 'username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passwordC,
                  obscureText: true, // password tersembunyi
                  decoration: InputDecoration(
                    hintText: 'password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: login, child: const Text('Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
