import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/utils/constants.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController t1;
  TextEditingController t2;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Add note'),
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            bool isDiscarded = false;
            isDiscarded = await _addOrDiscard(context, t1.text, t2.text);
            Navigator.pop(context, isDiscarded);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          bool isDiscarded = false;
          isDiscarded = await _addOrDiscard(context, t1.text, t2.text);
          Navigator.pop(context, isDiscarded);
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 26.0,
                ),
                TextField(
                  autofocus: true,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
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
                  style: const TextStyle(color: Colors.white),
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
      ),
    );
  }
}

Future<bool> _addOrDiscard(
  BuildContext context,
  String title,
  String content,
) async {
  bool isDiscarded = false;
  // if only title or content is note empty then update the note
  if (title.trim() != "" || content.trim() != "") {
    await context.read(NoteListViewModelProvider).addNote(Note.fromMap({
          'title': '$title',
          'content': '$content',
          'isPinned': 0,
          'date_created': '${DateTime.now()}',
          'last_updated': '${DateTime.now()}'
        }));
  }
  // if both title and content are note empty then discard the note
  else if (title.trim() == "" && content.trim() == "") {
    isDiscarded = true;
  }

  return isDiscarded;
}
