import 'package:flutter/material.dart';
import 'package:learning_fire/Models/user.dart';
import 'package:learning_fire/Services/auth.dart';
import 'package:learning_fire/screeans/Authentication/authentication.dart';
import 'package:learning_fire/screeans/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
