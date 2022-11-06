// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:crew_brew/models/Brew.dart';
import 'package:crew_brew/screens/home/brew_list.dart';
import 'package:crew_brew/screens/home/settings_form.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authe = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(color: Colors.brown[100]),
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>?>.value(
      value: database(uid: '').brews,
      initialData: null,
      catchError: (context, error) => null,
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => _showSettingsPanel(),
              icon: const Icon(Icons.menu_rounded),
            ),
            TextButton(
              onPressed: () async {
                _authe.signOutFromGoogle();
              },
              child: Row(
                children: [Text('Log Out'), Icon(Icons.person)],
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
