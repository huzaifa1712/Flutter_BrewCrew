import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';
import 'package:brew_crew/models/BrewModel.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamProvider<List<BrewModel>>.value(
        value: DatabaseService().brews,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text("Brew Crew"),
            backgroundColor: Colors.brown[400],
            actions: <Widget>[
               FlatButton.icon(
                 icon: Icon(Icons.person),
                 label: Text("Log out"),
                 onPressed: () async {
                  await _auth.signOut();
                 },
               )
            ],
          ),
          body: BrewList(),
        ),
      ),
    );
  }
}
