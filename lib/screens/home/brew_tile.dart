import 'package:flutter/material.dart';
import 'package:brew_crew/models/BrewModel.dart';

class BrewTile extends StatelessWidget {
  final BrewModel brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      // Card is typically used to nest a ListTile inside it
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        // ListTile is the building block of a list - leading goes on left, title and subtitle
        // are two pieces of text
        // brew.strength goes from 100 to 900 so we can use it directly to change color of avatar
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),

    );
  }
}
