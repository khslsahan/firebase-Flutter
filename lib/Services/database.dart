import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_fire/Models/brew.dart';
import 'package:learning_fire/Models/user.dart';


class DatabaseService{

    final String uid;

    DatabaseService({this.uid});
    //collection reference

    final CollectionReference  ssCollection =  Firestore.instance.collection('gods');

    Future updateUserData(String sugers , String name , int strength) async {
      return await  ssCollection.document(uid).setData(
        {'sugers':sugers,
          'name':name,
          'strength':strength,
        }
      );
    }

    //brew list from snapshot
    List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot){
      return snapshot.documents.map( (doc){
        return Brew(
          name: doc.data['name'] ?? '0',
          strength: doc.data['strength'] ?? 0,
          sugers: doc.data['sugers']  ?? '0',
        );
      }).toList();
    }


    // User Data from snapshot

    UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
      return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']
      );
    }


    // get brew Streams

    Stream<List<Brew>> get brews{
      return ssCollection.snapshots()
      .map(_brewListFromSnapShot);
    }



    // get user doc streams

  Stream<UserData> get userData{
      return ssCollection.document(uid).snapshots()
      .map(_userDataFromSnapShot);
  }
}