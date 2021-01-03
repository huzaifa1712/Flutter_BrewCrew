import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/models/UserModel.dart';
import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  // form key for form submission and sugars list for dropdown
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];


  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  
  String submitMessage = "";
  bool submitErr = false;

  @override
  Widget build(BuildContext context) {
    // using Provider to access the UserModel passed through wrapper so we can use the uid
    // to access the correct brew in DatabaseService (corresponding to the user)
    // has to be in build method because of context
    final user = Provider.of<UserModel>(context);

    // StreamBuilder<UserData> takes a stream of type UserData and rebuilds the widget tree
    // returned in builder everytime there is an event from the Stream (e.g change in data)
    // this is because userData is returned through doc.snapshots() which itself returns a
    // DocumentSnapshot stream
    // snapshot in builder returns to the data returned from the stream of type UserData, not
    // the Firebase snapshot
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        // if the snapshot has data we can build the Form and populate it with initial (previous)
        // values
        if(snapshot.hasData){

          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height:20.0),
                TextFormField(
                  // initialValue sets an initial value for the field, in this case the existing name
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: "Name"),
                  validator: (val) => val.isEmpty ? 'Please enter a name.' : null,
                  onChanged: (val) => setState( () => _currentName = val),
                ),

                SizedBox(height:20.0),
                // Dropdown (Sugars)
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  // set the value shown in the dropdown to _currentSugars or if null set to
                  // the existing value from userData
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar){
                    String _text = sugar + (int.parse(sugar) == 1 ? ' sugar' : ' sugars');
                    return DropdownMenuItem(
                      // value is set to the value that should return in onChanged when
                      // the respective item is selected (0,1,2,3,4). child is the actual widget
                      // shown in the item
                      value: sugar,
                      child: Text(_text),
                    );
                  }).toList(),

                  onChanged: (val){
                    setState(() {
                      // set currentSugars to the value selected once a selection has happen(on change)
                      _currentSugars = val;
                    });
                  },
                ),
                // Slider (Strength)
                Slider(
                  // Slider value has to be a Double so we select either current Strength or if null
                  // use existing strength from userData then convert to double
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    // changes the color of the slider based on strength being selected
                    activeColor: Colors.brown[(_currentStrength ?? userData.strength)], // left side of slider + circle
                    inactiveColor: Colors.brown[(_currentStrength ?? userData.strength)] , // right side
                    label: ((_currentStrength ?? userData.strength)/100).round().toString(), // label is the text that shows when moving slider
                    min: 100,
                    max: 900,
                    divisions: 8, // 900 -100 = 800, 800/100 = 8
                    onChanged: (val) => setState( () => _currentStrength = val.round())
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    _currentName = _currentName ?? userData.name;
                    _currentStrength = _currentStrength ?? userData.strength;
                    _currentSugars = _currentSugars ?? userData.sugars;

                    DatabaseService(uid: user.uid).updateBrew(
                      name: _currentName,
                      strength: _currentStrength,
                      sugars: _currentSugars
                    ).then((value) => setState( (){
                      submitMessage = "Brew updated";
                    }))
                    .catchError((onError) => setState( (){
                      submitMessage = "There was an issue";
                      submitErr = true;
                    }));

                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  submitMessage,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: submitErr ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          );
        } else{
            // if no data from snapshot, return loading screen
            return Loading();
        }


      }
    );
  }
}
