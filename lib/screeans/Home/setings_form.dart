import 'package:flutter/material.dart';
import 'package:learning_fire/Models/user.dart';
import 'package:learning_fire/Services/database.dart';
import 'package:learning_fire/shared/constants.dart';
import 'package:learning_fire/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4','5'];

  String _currentName;
  String _currentSugars;
  int _cuttentStrength;


  Widget build(BuildContext context) {

    final user  = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update  Brews Settings'
                  ,style:  TextStyle(fontSize: 20 , color: Colors.pink),),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration ,
                  validator:  (val) => val.isEmpty ? 'Pleace Enter Name' : null,
                  onChanged:  (val){
                    setState(() {
                      _currentName =val;
                    });
                  },

                ),
                SizedBox(height: 20.0,),

                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value:  _currentSugars ?? '1',
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text(' ${sugar} Sugers '),

                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _currentSugars =val;
                    });
                  },
                ),


                Slider(
                  value: (_cuttentStrength ?? userData.strength ).toDouble(),
                  activeColor: Colors.blue[_cuttentStrength ?? userData.strength],
                  inactiveColor: Colors.blue[_cuttentStrength ?? userData.strength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val){
                    setState(() {
                      _cuttentStrength =val.round();
                    });
                  },
                ),

                RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Update', style: TextStyle( color: Colors.white),
                  ),
                  onPressed: () async {
//                    print(_currentName);
//                    print(_currentSugars);
//                    print(_cuttentStrength);
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName  ?? userData.name,
                          _cuttentStrength ?? userData.strength
                      );
                    Navigator.pop(context);
                          }

                  },
                )
              ],
            ),
          );

        }else{
           return Loading();
        }

      }
    );
  }
}
