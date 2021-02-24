import 'package:flutter/material.dart';
import 'package:notes/pages/addNotePage.dart';
import 'package:notes/widgets/fab.dart';
import 'package:notes/widgets/notes_grid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        // Dark Mode color
        backgroundColor: Color(0xFF2c3342),
      ),
      // Dark Mode color
      backgroundColor: Color(0xFF222733),
      // body: NotesList(),
      body: NotesGrid(),
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
