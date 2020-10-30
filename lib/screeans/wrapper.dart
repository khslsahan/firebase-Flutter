import 'package:flutter/material.dart';
import 'package:learning_fire/screeans/Authentication/authentication.dart';
import 'package:learning_fire/screeans/Home/home.dart';
import 'package:provider/provider.dart';
import 'package:learning_fire/Models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user  = Provider.of<User>(context);
    print(user);
    if( user == null){
      return Authenticate();
    }else{
      return Home();
    }

  }
}
