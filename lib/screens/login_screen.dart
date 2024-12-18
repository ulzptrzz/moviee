import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapps/widgets/bottom_nav_bar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  loginScreenState createState() => loginScreenState();
}

class loginScreenState extends State<loginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _register() async {
    final UserCredential userCredential =
        (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text));

    User? user = userCredential.user;

    if (user != Null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => loginScreen()));
    }
  }

  void _signIn(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Navigasi ke halaman BottomNavBar jika login sukses
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = 'Pengguna tidak ditemukan!';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password yang dimasukkan salah!';
      } else {
        errorMessage = 'Pengguna atau password yang anda masukkan salah!';
      }

      _showErrorDialog(context, errorMessage);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Widget _renderSignIn() {
    return Container(
      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/TulisanLayarku.png",
              width: 200,
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: _emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Email',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Password',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: const BorderSide(width: 1, color: Colors.grey),
              ),
              child: const Text(
                "Sign in",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "Silahkan masukkan email dan password anda"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog'),
                                child: const Text("Ok"),
                              )
                            ],
                          ));
                  return;
                }
                _signIn(context);
              },
            ),
          ),
          const SizedBox(height: 40),
          MaterialButton(
            child: const Text(
              "Belum mempunyai akun? Daftar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          const SizedBox(height: 10.0),
          MaterialButton(
            child: const Text(
              "Lupa password?",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _renderSignUp() {
    return Container(
      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/TulisanLayarku.png",
              width: 200,
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          TextField(
            controller: _nameController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Nama anda',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Email',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Password',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: const BorderSide(width: 1, color: Colors.grey),
              ),
              child: const Text(
                "Sign up",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                final name = _nameController.text;

                if (email.isEmpty || password.isEmpty || name.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "Silahkan masukkan email,password dan nama anda"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog'),
                                child: const Text("Ok"),
                              )
                            ],
                          ));
                  return;
                }
                _register();
              },
            ),
          ),
          const SizedBox(height: 40),
          MaterialButton(
            child: const Text(
              "Sudah mempunyai akun? Masuk",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
          const SizedBox(height: 10.0),
          MaterialButton(
            child: const Text(
              "Lupa password?",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _renderSignIn(),
          _renderSignUp(),
        ],
      ),
    );
  }
}
