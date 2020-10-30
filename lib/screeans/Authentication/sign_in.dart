import 'package:flutter/material.dart';
import 'package:learning_fire/Services/auth.dart';
import 'package:learning_fire/shared/constants.dart';
import 'package:learning_fire/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  bool loading =false;

  String email = '';
  String password = '';
  String error =  '';

  @override
  Widget build(BuildContext context) {
    return  loading ? Loading(): Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
        title: Text('Sign In '),
        actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('Register'),
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
                validator: (val) => val.isEmpty ? 'Enter Email': null,
                onChanged: (val){
                    setState(() {
                      email = val;
                    });
                },
              ),SizedBox(height: 20,),
              TextFormField(

                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator:  (val) => val.length < 6 ? 'Enter 6 Character password': null,
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
                child: Text('Sign In'),
                onPressed: () async {
          if(_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                     //print(email);
//                        print(password);
                if(result== null){
                  setState(() {
                    error = 'Pleace Supply valid email and password';
                    loading = false;
                  });
                }
                }
                },
              ),
              SizedBox(height: 20,),
              Text(
                error,style: TextStyle( color: Colors.red , fontSize: 16),
              )
            ],
          ),
        ),
    ),
    );
  }
}
