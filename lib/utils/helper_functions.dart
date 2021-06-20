import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:notes/utils/constants.dart';

Flushbar emptyNoteDiscardedFlushbar = Flushbar(
  messageText: Text('Empty note discarded'),
  flushbarStyle: FlushbarStyle.FLOATING,
  dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  margin: EdgeInsets.only(bottom: 40.0, left: 15.0, right: 15.0),
  backgroundColor: kSnackBarColor,
  borderRadius: BorderRadius.circular(5.0),
  leftBarIndicatorColor: Colors.redAccent,
  duration: Duration(seconds: 2),
  // animationDuration: Duration(seconds: 10),
  forwardAnimationCurve: Curves.easeInOut,
  reverseAnimationCurve: Curves.easeInOut,
);
