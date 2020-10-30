import 'package:flutter/material.dart';
import 'package:learning_fire/Services/auth.dart';
import 'package:learning_fire/shared/constants.dart';
import 'package:learning_fire/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

    final _formKey = GlobalKey<FormState>();
    final AuthServices _auth = AuthServices();
    bool loading = false;

    String email='';
    String password = '';
    String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
            label: Text('sign In'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
//      body: Container(
//        padding: EdgeInsets.symmetric(vertical: 20.0 ,horizontal: 50.0),
//        child: RaisedButton(
//          child: Text('Sign in Annonymous'),
//          onPressed: () async{
//            dynamic result = await  _auth.signInAnon();
//            if(result == null){
//              print('Error in sign in');
//            }else{
//              print('Sign in ss');
//
//              print(result.uid);
//            }
//          },
//        ),
//      ),
      body: Container(

        padding: EdgeInsets.symmetric(vertical: 20.0 ,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter Email' : null ,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length <6 ? 'Enter 6 character password':null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.blue[800],
                child: Text('Register'),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email,password);
//                    print(email);
//                    print(password);
                    if(result == null){
                      setState(() {
                        error = 'Pleace suply valid email';
                        loading = false;
                      }

                      );
                    }
                  }
                },
              ),
              SizedBox(height: 20,),
              Text(
                error,
                style: TextStyle(color:  Colors.red,fontSize:  16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
