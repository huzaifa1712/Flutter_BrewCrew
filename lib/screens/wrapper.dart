import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/UserModel.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    print(user.uid);
    // return either home or authenticate
    return Authenticate();
  }
}
