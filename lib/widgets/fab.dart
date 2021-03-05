import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/providers/providers.dart';

class Fab extends StatefulWidget {
  final VoidCallback onPressed;
  Fab({this.onPressed});
  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab> with SingleTickerProviderStateMixin {
  AnimationController _hideFabAnimController;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
      value: 1,
    );
  }

  @override
  void dispose() {
    _hideFabAnimController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // the setupScroll(BuildContext context) function is used to addListener to the scrollController and animate the Fab based on
  // the ScrollDirection, it takes [BuildContext] as the input parameter to access the provider using the
  // [BuildContext] provided by the build method.
  void setupScroll(BuildContext context) {
    _scrollController = context.read(ScrollControllerProvider);
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;

        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // we call setupScroll(BuildContext context) function with the [BuildContext] , so we can access provider
    // using the [BuildContext].
    setupScroll(context);
    return FadeTransition(
      opacity: _hideFabAnimController,
      child: ScaleTransition(
        scale: _hideFabAnimController,
        child: IgnorePointer(
          ignoring: _hideFabAnimController.value== 0 ?true:false,
          child: FloatingActionButton(
            onPressed: widget.onPressed,
            tooltip: 'Add Note',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
