import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notes/utils/app_colors.dart';

class Fab extends StatelessWidget {
  final VoidCallback onPressed;
  Fab({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Add Note',
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: kFabColor,
      elevation: 8.0,
    );
  }
}
