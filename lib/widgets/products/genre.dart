import 'package:flutter/material.dart';

class GenreTag extends StatelessWidget {
  final String genre;

  GenreTag(this.genre);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        '\Genre: $genre',
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
