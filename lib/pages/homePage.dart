import 'package:flutter/material.dart';
import 'package:notes/pages/addNotePage.dart';
import 'package:notes/widgets/fab.dart';
import 'package:notes/widgets/notes_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController s = ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      body: NotesList(s: s),
      floatingActionButton: Fab(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNotePage()))
              .then((value) => setState(() {}));
        },
        s: s,
      ),
     
    );
  }
}
