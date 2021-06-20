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
                bool isDiscarded = false;
                if (isEdited) {
                  isDiscarded = await _updateOrDiscard(
                      context, t1.text, t2.text, currentNote);
                }
                Navigator.pop(context, isDiscarded);
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
        body: WillPopScope(
          onWillPop: () async {
            bool isDiscarded = false;
            if (isEdited) {
              isDiscarded = await _updateOrDiscard(
                  context, t1.text, t2.text, currentNote);
            }
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
      ),
    );
  }
}

Future<bool> _updateOrDiscard(
  BuildContext context,
  String title,
  String content,
  Note currentNote,
) async {
  bool isDiscarded = false;
  // if only title or content is note empty then update the note
  if (title.trim() != "" || content.trim() != "") {
    Note newNote = Note.fromMap(
      {
        'title': '$title',
        'content': '$content',
        'isPinned': 0,
        'date_created': '${DateTime.now()}',
        'last_updated': '${DateTime.now()}'
      },
    );
    newNote.id = currentNote.id;
    await context.read(NoteProvider(currentNote.id)).update(newNote);
  }
  // if both title and content are note empty then discard the note
  else if (title.trim() == "" && content.trim() == "") {
    await context
        .read(NoteListViewModelProvider)
        .deleteMultipleNotes([currentNote.id]);
    isDiscarded = true;
  }

  return isDiscarded;
}
