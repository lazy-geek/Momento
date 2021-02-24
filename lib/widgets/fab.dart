import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Fab extends StatefulWidget {
  VoidCallback onPressed;
  Fab({this.onPressed});
  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab> {
  @override
  Widget build(BuildContext context) {
    // return AnimatedOpacity(duration: Duration(milliseconds: 500),opacity: hidefab? 0 :1,
    //       child: IgnorePointer(ignoring: hidefab,
    //                   child: FloatingActionButton(
    //         onPressed: widget.onPressed,
    //         tooltip: 'Add Note',
    //         child: Icon(Icons.add),
    //     ),
    //       ),
    // );
    return FloatingActionButton(
      onPressed: widget.onPressed,
      tooltip: 'Add Note',
      child: Icon(Icons.add),
    );
  }
}
