import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/utils/constants.dart';

class EditNotePage extends StatefulWidget {
  final String page;
  final int id;
  EditNotePage({this.page, this.id});
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
    // currentNote = widget.page=='home' ? context.read(NoteProvider(widget.id)): context.read(SingleSearchResultProvider(widget.id));
    currentNote = context.read(NoteProvider(widget.id));
    t1.text = currentNote.title;
    t2.text = currentNote.content;
  }

  @override
  Widget build(BuildContext context) {
    setupText(context);
    return Hero(
      tag: widget.id.toString() + widget.page.toString(),
      transitionOnUserGestures: true,
      // flightShuttleBuilder: (
      //   BuildContext flightContext,
      //   Animation<double> animation,
      //   HeroFlightDirection flightDirection,
      //   BuildContext fromHeroContext,
      //   BuildContext toHeroContext,
      // ) {
      //   // this fixes issue which causes yellow underline to apear when trasitioning back
      //   return DefaultTextStyle(
      //     style: DefaultTextStyle.of(fromHeroContext).style,
      //     child: toHeroContext.widget,
      //   );
      // },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
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
                  await context
                      .read(NoteProvider(currentNote.id))
                      .update(newNote);
                }
                Navigator.pop(context);
              }),
          actions: [
            Consumer(
              builder: (context, watch, child) {
                Note note = watch(NoteProvider(currentNote.id));
                if (note.isPinned == 1) {
                  return IconButton(
                  icon: Icon(Icons.push_pin),
                  onPressed: () {
                    context.read(NoteListViewModelProvider).unsetPin([note]);
                  },
                );
                } else {
                  return IconButton(
                  icon: Icon(Icons.push_pin_outlined),
                  onPressed: () {
                    context.read(NoteListViewModelProvider).setPin([note]);
                  },
                );
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 26.0,
                ),
                Column(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
