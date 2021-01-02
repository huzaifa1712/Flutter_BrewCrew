import 'package:brew_crew/screens/home/settings_form.dart';
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
    // this function is here as it needs access to the BuildContext
    // builder returns a widget tree that is shown when the bottom sheet is triggered
    void _showSettingsPanel(){
      showModalBottomSheet(context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          }
      );
    }

    return Container(
      child: StreamProvider<List<BrewModel>>.value(
        value: DatabaseService().brews,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text("Brew Crew"),
            backgroundColor: Colors.brown[400],
            actions: <Widget>[
              // Log out
               FlatButton.icon(
                 icon: Icon(Icons.person),
                 label: Text("Log out"),
                 onPressed: () async {
                  await _auth.signOut();
                 },
               ),
              // Settings button
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text("Settings"),
                // this function triggers showing of the bottom sheet
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          body: BrewList(),
        ),
      ),
    );
  }
}
