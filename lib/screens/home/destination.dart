import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, Colors.blue),
  Destination('Account', Icons.account_circle, Colors.blue),
  Destination('Post', Icons.assessment, Colors.blue),
  Destination('Statistics', Icons.create, Colors.blue)
];