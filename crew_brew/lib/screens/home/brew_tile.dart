import 'package:crew_brew/models/Brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.brown.shade100,
              blurRadius: 10.0,
              spreadRadius: 5,
            )
          ],
        ),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/coffee_icon.png'),
              radius: 25,
              backgroundColor: Colors.brown[brew.strength],
            ),
            title: Text(brew.name),
            subtitle: Text('drink\'s ${brew.sugars} sugar(s)'),
          ),
        ),
      ),
    );
    ;
  }
}
