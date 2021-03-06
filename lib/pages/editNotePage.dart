import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/providers.dart';

class EditNotePage extends StatefulWidget {
  final int index;
  EditNotePage({this.index});
  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController t1;
  TextEditingController t2;
  bool isEdited;
  Note currentNote;

  @override
  void initState() {
    super.initState();
    isEdited = false;

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
      backgroundColor: const Color(0xFF222733),
      appBar: AppBar(
        title: const Text('Edit note'),
        centerTitle: true,
        // Dark Mode color
        backgroundColor: const Color(0xFF2c3342),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
                await context.read(NoteProvider(widget.index)).update(newNote);
              }
              Navigator.pop(context);
            }),
      ),
      body: Hero(
        tag: widget.index,
        transitionOnUserGestures: true,
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          // this fixes issue which causes yellow underline to apear when trasitioning back
          return DefaultTextStyle(
            style: DefaultTextStyle.of(fromHeroContext).style,
            child: toHeroContext.widget,
          );
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 26.0,
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (_) {
                          isEdited = true;
                        },
                        showCursor: true,
                        autofocus: true,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
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
                        style: const TextStyle(color: Colors.white),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
