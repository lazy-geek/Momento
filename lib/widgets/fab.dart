import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Fab extends StatefulWidget {
  VoidCallback onPressed;
  ScrollController s;
  Fab({this.onPressed,this.s});
  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab> {
  bool hidefab = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.s.addListener(() {
        if(widget.s.position.userScrollDirection ==ScrollDirection.forward)
      {
        
        if(hidefab == false){
          setState(() {
            
          hidefab= true;
          });
        }
      }else if(widget.s.position.userScrollDirection ==ScrollDirection.reverse)
      {
        if(hidefab == true){
          setState(() {
            
          hidefab= false;
          });
        }
      }
      
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(duration: Duration(milliseconds: 500),opacity: hidefab? 0 :1,
          child: IgnorePointer(ignoring: hidefab,
                      child: FloatingActionButton(
            onPressed: widget.onPressed,
            tooltip: 'Add Note',
            child: Icon(Icons.add),
        ),
          ),
    );
  }
}