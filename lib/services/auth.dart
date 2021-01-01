import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/UserModel.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on Firebse
  UserModel _userFromFirebase(User user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // auth change user stream
  // this is a stream that returns a User object everytime there is a change
  // in authentication state
  Stream<UserModel> get user{
    // authStateChanges returns a User class from Firebase, so map
    // turns it into a UserModel class using our custom function
    return _auth.authStateChanges()
        //.map((User user) => _userFromFirebase(user));
        .map(_userFromFirebase); // - does the same as above
  }
  // sign in anonymously
  Future signInAnon() async{
    try{
      // result of async sign in using firebase auth - result.user is the User object
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebase(user);

    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out anonymously

  // sign in with email and password

  // register with email and password

  // sign out
  Future signOut() async{
    try{
      await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}