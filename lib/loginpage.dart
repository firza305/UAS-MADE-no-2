import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakeriot/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _usernameErrorText;
  String? _passwordErrorText;

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: username, password: password)
        .then((value) => Get.offAll(const HomePage()));
    Get.snackbar(
      'Login Successful',
      'Welcome, $username',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color.fromARGB(213, 255, 255, 255),
      colorText: Colors.purple,
    );

    setState(() {
      _usernameErrorText = null;
      _passwordErrorText = null;
    });

    try {
      if (username.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: password,
        );
      } else {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: username,
          password: password,
        );
      }

      if (e is FirebaseAuthException) {
        setState(() {
          _usernameErrorText = 'Invalid username or password';
          _passwordErrorText = 'Invalid username or password';
        });
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    if (username == 'Admin' && password == '1234567') {
      Get.offAll(const HomePage());
      Get.snackbar(
        'Login Successful',
        'Welcome, $username',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color.fromARGB(212, 255, 255, 255),
        colorText: Colors.purple,
      );
    } else {
      setState(() {
        _usernameErrorText = null;
        _passwordErrorText = null;

        if (username != 'Admin') {
          _usernameErrorText = 'Invalid username';
        }
        if (password != '1234567') {
          _passwordErrorText = 'Invalid password';
        }
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 55, 1, 112),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 250.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Login Form',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(color: Colors.white),
                          errorText: _usernameErrorText,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          errorText: _passwordErrorText,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) {},
                                activeColor: Colors.white,
                              ),
                              const Text(
                                'Remember Me',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Register here',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: _login,
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
