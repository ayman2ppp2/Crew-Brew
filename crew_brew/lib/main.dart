// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:crew_brew/models/UserModel.dart';
import 'package:crew_brew/screens/wrapper.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthService().userStream,
      child: MaterialApp(
        home: Wrapper(),
      ),
    ),
  );
}
