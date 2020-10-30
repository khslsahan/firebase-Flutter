import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning_fire/Models/user.dart';
import 'package:learning_fire/Services/database.dart';


class AuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user based o Firebase user

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }


  // Authchange using the Stream

  Stream<User> get user {
    return  _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
    //.map((FirebaseUser user)=> _userFromFirebaseUser(user));
  }



  //sign in annonymous

  Future signInAnon() async{
    try{
        AuthResult result = await _auth.signInAnonymously();
        print(result);
        FirebaseUser user = result.user;
        print(user);
        return _userFromFirebaseUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }


  //sign in with email password
  Future signInWithEmailAndPassword(String email,String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  // register with email and password

  Future registerWithEmailAndPassword(String email, String password) async{
    try{
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;

        // create  new document for user with uid
        await DatabaseService(uid:  user.uid).updateUserData('0',  'New user name', 100);

        return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }



  // sign out


  Future signOut() async {
    try{
            return await _auth.signOut();
    }catch(e){
            print(e.toString());
            return null;
    }
  }

}