import 'package:cloud_firestore/cloud_firestore.dart';
// Firestore stores data as documents in collections, with each document being
// an analog to an individual object - just like Mongo. Collections are of similar data - so
// for example the User collection or Defects collection
FirebaseFirestore firestore = FirebaseFirestore.instance;

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection = firestore.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async{
    // Firestore creates documents and collections if they do not already exist
    // brewCollection.doc(uid) returns a reference to the document with index uid in the collection
    // if it does not exist, a document with that index is created in the collection brews

    // simply setting a reference to a document using collection.doc(id) doesn't perform network
    // operations. but get and set would.
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });

  }
}