import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/view_model/note_list_view_model.dart';
class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  NoteListViewModel noteListViewModel;
  @override
  void initState() {
    super.initState();
    noteListViewModel= NoteListViewModel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add note'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await noteListViewModel.addNote(
            Note.fromMap(
              {
              'title':'${t1.text}',
              'content':'${t2.text}',
              'isPinned':0,
              'date_created':'$DateTime.now().day',
              'last_updated':'$DateTime.now().day'
              }
            )
          );


              Navigator.pop(context);
            }),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              style: TextStyle(fontSize: 25),
              controller: t1,
              maxLines: null,
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: 'Title',
                  border: InputBorder.none),
            ),
            TextField(
              maxLines: null,
              controller: t2,
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: 'Type Something',
                  border: InputBorder.none),
            )
          ],
        ),
      ),
    );
  }
}