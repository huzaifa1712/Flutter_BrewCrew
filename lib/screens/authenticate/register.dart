import 'package:brew_crew/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  // named parameter constructor: when calling constructor, have to use named param
  // i.e Register(toggleView: toggleView)
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}
        
class _RegisterState extends State<Register> {
  // auth in order to access auth service
  // formKey in order to enable validation for register form
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Sign Up for Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In"))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                // Email Form Field
                TextFormField(
                  // textInputDecoration is a defined variable in the constants.dart file
                  // containing properties for the decoration.
                  // copyWith returns a new instance of the object with the desire properties
                  // changed according to what is passed in. So we can reuse the same style
                  // for every form field with different properties for placeholder text
                  decoration:textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (value){
                    return value.isEmpty ? "Enter an email" : null;
                  },
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                ),

                SizedBox(height: 20.0),
                // Password Form Field
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (value){
                    return value.length < 6 ? "Please enter a password 6+ characters long" : null;
                  },
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),

                SizedBox(height: 20.0),
                RaisedButton(
                  color:Colors.pink[400],
                  child: Text("Sign up", style: TextStyle(color: Colors.white)),
                  // Sign up button
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      // if form fields are valid proceed with register
                      // result is dynamic because it could be null
                      setState(() {
                        loading = true;
                      });

                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                      if(result == null){
                        setState(() {
                          error = "Please use a valid e-mail and password";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height:12.0),
                // Error message
                Text(error,
                style: TextStyle(color: Colors.red, fontSize: 14.0)
                )
              ],
            ),
          )
      ),
    );
  }
}
