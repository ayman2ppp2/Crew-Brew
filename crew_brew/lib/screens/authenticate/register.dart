import 'package:crew_brew/models/UserModel.dart';
import 'package:crew_brew/screens/authenticate/signIn.dart';
import 'package:crew_brew/screens/loading.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({super.key, required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>();
  final AuthService _authe = AuthService();
  String error = '';
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
              title: Text('sign up to brew crew'),
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
                      height: 20,
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
                      height: 20,
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
                              await _authe.RegisterWithEmailAndPassword(
                                  email, password);
                          if (result == null) {
                            setState(() {
                              error = 'please enter a valid email and password';
                              loadingScreen = false;
                            });
                          }
                        }
                      },
                      child: Text('register'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(' have an account ? '),
                        TextButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: Text('login'),
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
