import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // variables to store text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Sign In to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign up"))
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
                decoration:textInputDecoration.copyWith(hintText: 'Email'),
                validator: (value){
                  return value.isEmpty ? "Enter an email" : null;
                },
                onChanged: (val){
                  // call setState so that widgets can be rebuilt
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
              // Sign In Button
              RaisedButton(
                color:Colors.pink[400],
                child: Text("Sign in", style: TextStyle(color: Colors.white)),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                    if(result == null){
                      setState(() {
                        error = "Please use a valid email and password";
                      });

                    }

                  }
                },
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        )
      ),
    );
  }
}

// RaisedButton(
// child: Text("Sign in anon"),
// onPressed: () async {
// dynamic result = await _auth.signInAnon();
//
// if(result == null){
// print("Error signing in");
// }
//
// else{
// print("Signed In");
// print(result.uid);
// }
// },
// ),