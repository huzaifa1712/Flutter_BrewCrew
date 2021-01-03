import 'package:brew_crew/models/BrewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    // set brews to empty array if no brews are available
    final brews = Provider.of<List<BrewModel>>(context) ?? [];


    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugars);
      print(brew.strength);
    });
    // This returns a ListView using the builder function - we can pass the index (0 to n-1)
    // into the constructor for BrewTile as well
    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (BuildContext context, int index){
          return BrewTile(brew: brews[index]);
        },
    );
  }
}
