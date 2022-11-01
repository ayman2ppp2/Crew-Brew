import 'package:crew_brew/models/UserModel.dart';
import 'package:crew_brew/screens/authenticate/register.dart';
import 'package:crew_brew/screens/loading.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authe = AuthService();

  String error = '';
  late String email;
  late String password;
  bool loadingScreen = false;

  @override
  Widget build(BuildContext context) {
    return loadingScreen
        ? loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: Text('sign in to brew crew'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'email',
                      ),
                      validator: (value1) =>
                          value1!.isEmpty ? 'please Enter an email' : null,
                      onChanged: (value1) {
                        setState(() {
                          email = value1;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'password',
                      ),
                      validator: (value2) => value2!.length < 6
                          ? 'password must be more than 6 chars'
                          : null,
                      obscureText: true,
                      onChanged: (value2) {
                        setState(() {
                          password = value2;
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loadingScreen = true;
                          });
                          dynamic result =
                              await _authe.SignInWithEmailAndPassword(
                                  email, password);
                          print('here');
                          if (result == null) {
                            setState(() {
                              error = 'please enter a valid email and password';
                              loadingScreen = false;
                            });
                          }
                        }
                      },
                      child: Text('login'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text('don\'t have an account ? '),
                        TextButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: Text('register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
