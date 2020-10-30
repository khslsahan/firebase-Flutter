import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learning_fire/Models/brew.dart';
import 'package:learning_fire/Services/auth.dart';
import 'package:learning_fire/screeans/Home/brewList.dart';
import 'package:learning_fire/screeans/Home/setings_form.dart';
import 'package:provider/provider.dart';
import 'package:learning_fire/Services/database.dart';

class Home extends StatelessWidget {

  final AuthServices _auth = AuthServices();



  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 60),
            child: SettingsForm(),
          );
        });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: Text('Learnoing Fire'),
          elevation: 0.0,
          actions: <Widget>[
             FlatButton.icon(
                 onPressed: () async {
                          await _auth.signOut();
                       },
                 icon: Icon(Icons.person ),
                 label: Text('Logout')),
            FlatButton.icon(
                onPressed: ()  {
                   _showSettingsPanel();
                },
                icon: Icon(Icons.settings ),
                label: Text('Settings'))


          ],
        ),
        body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('asserts/image.jpg'),
            fit: BoxFit.cover
          ),

        ),
            child: BrewList()
        ),
      ),
    );
  }
}
