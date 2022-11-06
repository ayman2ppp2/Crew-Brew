// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:crew_brew/models/UserModel.dart';
import 'package:crew_brew/screens/constants.dart';
import 'package:crew_brew/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final useerr = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
        stream: database(uid: useerr.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? data = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'update your brew settings.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'your name',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 2),
                      ),
                    ),
                    validator: (value) => value == _currentName!.isEmpty
                        ? 'please enter a name'
                        : null,
                    onChanged: (value) => setState(
                      () {
                        _currentName = value;
                      },
                    ),
                    initialValue: data!.name,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // dropdown
                  DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ?? data.sugars,
                      items: sugars.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('$e sugars'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _currentSugars = value!;
                        });
                      }),

                  //slider
                  Slider(
                    value: (_currentStrength ?? data.strength).toDouble(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                    inactiveColor: Colors.brown[200],
                    activeColor:
                        Colors.brown[_currentStrength ?? data.strength],
                  ),
                  ElevatedButton(
                    child: Text(
                      'update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: (() async {
                      await database(uid: useerr.uid).updateUserData(
                          _currentSugars ?? data.sugars,
                          _currentName ?? data.name,
                          _currentStrength ?? data.strength);
                      Navigator.pop(context);
                    }),
                  ),
                ],
              ),
            );
          } else {
            return loading();
          }
        });
  }
}
