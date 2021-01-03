class UserModel{
  final String uid;

  // this automatically sets the uid variable to the parameter passed in to the constructor
  UserModel({this.uid});
}

// user data model for more properties
class UserData{
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.name, this.sugars, this.strength});
}