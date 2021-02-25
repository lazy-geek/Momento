import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dark Mode color
      backgroundColor: Color(0xFF222733),
      appBar: AppBar(
        title: Text('Add note'),
        centerTitle: true,
        // Dark Mode color
        backgroundColor: Color(0xFF2c3342),
        leading: Consumer(
          builder: (context, watch, child) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async {
                  await context
                      .read(NoteListViewModelProvider)
                      .addNote(Note.fromMap({
                        'title': '${t1.text}',
                        'content': '${t2.text}',
                        'isPinned': 0,
                        'date_created': '$DateTime.now().day',
                        'last_updated': '$DateTime.now().day'
                      }));

                  Navigator.pop(context);
                });
          },
        ),
      body: Container(padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: 26.0,),
            TextField(
              autofocus: true,
                style: TextStyle(fontSize: 25, color: Colors.white),
              controller: t1,
              maxLines: null,
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none),
            ),
            TextField(
              maxLines: null,
              controller: t2,
                style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: 'Type Something',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none),
            )
          ],
        ),
      ),
    );
  }
}