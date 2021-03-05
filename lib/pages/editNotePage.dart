import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/providers.dart';

class EditNotePage extends StatefulWidget {
  int index;
  EditNotePage({this.index});
  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController t1;
  TextEditingController t2;
  bool isEdited = false;
  Note currentNote;

  @override
  void initState() {
    super.initState();

    t1 = TextEditingController();
    t2 = TextEditingController();
  }

  @override
  void dispose() {
    t1.dispose();
    t2.dispose();
    super.dispose();
  }

  void setupText(BuildContext context) {
    currentNote = context.read(NoteProvider(widget.index));
    t1.text = currentNote.title;
    t2.text = currentNote.content;
  }

  @override
  Widget build(BuildContext context) {
    setupText(context);
    return Scaffold(
      // Dark Mode color
      backgroundColor: Color(0xFF222733),
      appBar: AppBar(
        title: Text('Edit note'),
        centerTitle: true,
        // Dark Mode color
        backgroundColor: Color(0xFF2c3342),
        leading: Consumer(
          builder: (context, watch, child) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async {
                  if (isEdited) {
                    Note newNote = Note.fromMap(
                      {
                        'title': '${t1.text}',
                        'content': '${t2.text}',
                        'isPinned': 0,
                        'date_created': '$DateTime.now().day',
                        'last_updated': '$DateTime.now().day'
                      },
                    );
                    newNote.id = currentNote.id;
                    // print(widget.currentNote.content);
                    await context
                        .read(NoteProvider(widget.index))
                        .update(newNote);
                  }
                  Navigator.pop(context);
                });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(
                height: 26.0,
              ),
              TextField(
                onChanged: (_) {
                  isEdited = true;
                },
                showCursor: true,
                autofocus: true,
                style: TextStyle(fontSize: 25, color: Colors.white),
                controller: t1,
                maxLines: null,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    focusedBorder: InputBorder.none,
                    hintText: 'Title',
                    border: InputBorder.none),
              ),
              TextField(
                onChanged: (_) {
                  isEdited = true;
                },
                style: TextStyle(color: Colors.white),
                maxLines: null,
                controller: t2,
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    hintText: 'Type Something',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: InputBorder.none),
              )
            ],
          ),
        ),
      ),
    );
  }
}
