import 'package:flutter/material.dart';
import 'package:learning_fire/Models/brew.dart';


class BrewTile extends StatelessWidget {

  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),

        color: Colors.blue[80],
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('asserts/hiclipart.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugers} Sugar(s)'),
        ),
      ),

    );
  }
}

