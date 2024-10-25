import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/login/bloc/login_bloc.dart';
import 'package:flutter_application_1/bloc_test/login/bloc/login_event.dart';
import 'package:flutter_application_1/bloc_test/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenBloc extends StatefulWidget {
  const LoginScreenBloc({super.key});

  @override
  State<LoginScreenBloc> createState() => _LoginScreenBlocState();
}

class _LoginScreenBlocState extends State<LoginScreenBloc> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(builder: (BuildContext context, state) {
          return SafeArea(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Column(
                  children: [
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
                                onChanged: (value) {
                                  context
                                      .read<LoginBloc>()
                                      .add(OnChangeEmail(email: value));
                                },
                                // controller: emailController,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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

                                onChanged: (value) => context
                                    .read<LoginBloc>()
                                    .add(OnChangePassword(password: value)),
                                // controller: passWordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.lock),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
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
                      onPressed: () {
                        context.read<LoginBloc>().add(OnLogin());
                      },
                      child: const Text('Login')),
                ),
              ],
            ),
          ));
        }),
      ),
    );
  }
}
