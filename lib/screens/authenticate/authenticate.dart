import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  // another way to do routing instead of Navigator:
  // since this screen should show either SignIn or Register, we can use this function and
  // the variable to toggle between the two.
  // Default when startup is true - so it shows SignIn. When button is pressed, toggleView is called
  // and showSignIn is set to false. setState triggers widget rebuild, so Register is now shown instead.
  // Reverse happens when button is pressed on Register screen.
  // Function is passed as param and initialised inside Register and SignIn widgets.
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
