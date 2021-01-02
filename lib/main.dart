import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/UserModel.dart';
import 'shared/loading.dart';

void main() async {
  // these first two lines are needed to intialise Firebase before continuing with the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialise = Firebase.initializeApp();

  @override
  // Guide to providers: https://medium.com/flutter-community/making-sense-all-of-those-flutter-providers-e842e18f45dd
  // Guide to constructors: https://medium.com/flutter-community/deconstructing-dart-constructors-e3b553f583ef

  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper()
      )
    );

  }
}