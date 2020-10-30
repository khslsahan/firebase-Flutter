import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_fire/Models/brew.dart';
import 'package:learning_fire/screeans/Home/brewTile.dart';
import 'package:provider/provider.dart';


class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
//    print(brews.documents);
//    for(var doc in brews.documents){
//      print(doc.data);
//    }
    try {
      brews.forEach((brew) {
        print(brew.name);
        print(brew.strength);
        print(brew.sugers);
      });
    }catch(e){
      print(e.toString());
    }
    return ListView.builder(
         itemCount: brews.length,
        itemBuilder: (context,index){
           return BrewTile(brew : brews[index]);
        });
  }
}
