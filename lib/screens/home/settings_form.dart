import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

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
  String _currentStrength;
  @override
  Widget build(BuildContext context) {
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
            decoration: textInputDecoration.copyWith(hintText: "Name"),
            validator: (val) => val.isEmpty ? 'Please enter a name.' : null,
            onChanged: (val) => setState( () => _currentName = val),
          ),

          SizedBox(height:20.0),
          // Dropdown (Sugars)
          DropdownButtonFormField(
              decoration: textInputDecoration,
              // set the value shown in the dropdown to current sugars or if null set to 0
              value: _currentSugars ?? '0',
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
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async{
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
          )
        ],
      ),
    );
  }
}
