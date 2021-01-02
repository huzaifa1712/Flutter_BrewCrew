import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/BrewModel.dart';
// Firestore stores data as documents in collections, with each document being
// an analog to an individual object - just like Mongo. Collections are of similar data - so
// for example the User collection or Defects collection
FirebaseFirestore firestore = FirebaseFirestore.instance;

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewsCollection = firestore.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async{
    // Firestore creates documents and collections if they do not already exist
    // brewCollection.doc(uid) returns a reference to the document with index uid in the collection
    // if it does not exist, a document with that index is created in the collection brews

    // simply setting a reference to a document using collection.doc(id) doesn't perform network
    // operations. but get and set would.
    return await brewsCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });

  }

  // brew list from snapshot
  // snapshot.docs is the list of DocumentSnapshots corresponding to all the brew documents
  // .map takes each document and outputs a BrewModel object with the respective properties
  // ?? says to assign to the expression on the right if it is not null, else assign to left
  // toList because .map is lazy - returns iterable
  List<BrewModel> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return BrewModel(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0'
      );
    }).toList();
  }

  // get brews stream
  // the same way we use a stream to listen for authentication changes, we can use a stream to listen
  // for changes to the brews collection
  // maps snapshots to above function
  Stream<List<BrewModel>> get brews{
    //return brewsCollection.snapshots().map((snapshot) => _brewListFromSnapshot(snapshot));
    // below is same as above
    return brewsCollection.snapshots().map((snapshot) => _brewListFromSnapshot(snapshot));
  }
}