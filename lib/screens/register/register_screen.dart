import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/register_response.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  final emailController = TextEditingController();

  bool isShowPass = false;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    final url = Uri.parse('http://10.22.20.8:4000/api/createUsers');
    final user = User(
        email: emailController.text,
        password: passWordController.text,
        name: userNameController.text);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final registerRes = RegisterResponse.fromJson(data);
      print('Data: ${registerRes.toString()}');
    } else {
      print('Request failed with status: ${response.body.toString()}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Not empty';
                      }
                      return null;
                    },
                    controller: userNameController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: 'UserName'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Not empty';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: 'Email'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Not empty';
                      }
                      return null;
                    },
                    controller: passWordController,
                    obscureText: isShowPass,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isShowPass = !isShowPass;
                              });
                            },
                            icon: Icon(isShowPass
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16)),
                  child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await register();
                        }
                      },
                      child: const Text('Register')),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
