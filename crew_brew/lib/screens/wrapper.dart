import 'package:crew_brew/firebase_options.dart';
import 'package:crew_brew/models/UserModel.dart';
import 'package:crew_brew/screens/authenticate/authenticate.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  void init() async {}

  @override
  Widget build(BuildContext context) {
    init();

    final user = Provider.of<UserModel?>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
