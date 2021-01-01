import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  // variables to store text field state
  String email = "";
  String password = "";

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
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              onChanged: (val){
                // call setState so that widgets can be rebuilt
                setState(() {
                  email = val;
                });
              },
            ),

            SizedBox(height: 20.0),
            TextFormField(
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
              child: Text("Sign in", style: TextStyle(color: Colors.white)),
              onPressed: () async{
                print(email);
                print(password);
              },
            )
          ],
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