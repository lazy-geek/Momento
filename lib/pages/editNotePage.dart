import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/utils/constants.dart';
import 'package:notes/widgets/last_edited_label.dart';
import 'package:notes/widgets/note_pin.dart';
import 'package:share_plus/share_plus.dart';

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
  Note currentNote;
  int isPinned;
  bool isEdited;
  @override
  void initState() {
    super.initState();

    currentNote = context.read(NoteProvider(widget.id));
    isPinned = currentNote.isPinned;

    t1 = TextEditingController();
    t2 = TextEditingController();

    // make sure to add listeners after the intial value has been set
    // because we don't to notify listeners when the initial value is set
    
    t1.text = currentNote.title;
    t1.addListener(() {
      // this fixes the issue where all listeners were notified When TextField was focused
      t1.value = TextEditingValue(text: t1.text,selection: TextSelection.collapsed(offset: t1.text.length));
    });
    
    t2.text = currentNote.content;
     t2.addListener(() {
       // this fixes the issue where all listeners were notified When TextField was focused
      t2.value = TextEditingValue(text: t2.text,selection: TextSelection.collapsed(offset: t2.text.length));
    });
    
    isEdited = a.value;
  }

  @override
  void dispose() {
    t1.dispose();
    t2.dispose();
    a.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      context, t1.text, t2.text, currentNote, isPinned);
                }
                Navigator.pop(context, isDiscarded);
                
              }),
          actions: [
            // Consumer(
            //   builder: (context, watch, child) {
            //     Note note = watch(NoteProvider(currentNote.id));
            //     if (note == null) return Container();
            //     if (note.isPinned == 1) {
            //       return IconButton(
            //         icon: Icon(Icons.push_pin),
            //         onPressed: () {
            //           context.read(NoteListViewModelProvider).unsetPin([note]);
            //         },
            //       );
            //     } else {
            //       return IconButton(
            //         icon: Icon(Icons.push_pin_outlined),
            //         onPressed: () {
            //           context.read(NoteListViewModelProvider).setPin([note]);
            //         },
            //       );
            //     }
            //   },
            // ),
            NotePin(
              isPinned: isPinned,
              onChanged: (val) {
              isPinned = val;
              isEdited = true;
                a.value = true;
              },
            ),
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(t1.text + '\n' + t2.text, subject: t1.text);
            })
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            bool isDiscarded = false;
            if (isEdited) {
              isDiscarded = await _updateOrDiscard(
                  context, t1.text, t2.text, currentNote, isPinned);
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
                        onChanged: (val) {
                          isEdited = true;
                          a.value = true;
                        },
                        // showCursor: true,
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
                        onChanged: (val) {
                          isEdited = true;
                          a.value = true;
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
        bottomSheet: Container(
          height: 50.0,
          // padding: EdgeInsets.only(bottom: 8.0),
          color: kBackgroundColor,
          child: Column(
            children: [
              Center(
                child: LastEditedLabel(
                  last_updated: currentNote.last_updated,
                ),
              )
            ],
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
  int isPinned,
) async {
  bool isDiscarded = false;
  // if only title or content is note empty then update the note
  if (title.trim() != "" || content.trim() != "") {
    Note newNote = Note.fromMap(
      {
        'title': '$title',
        'content': '$content',
        'isPinned': isPinned,
        'last_updated': '${DateTime.now()}'
      },
    );
    newNote.id = currentNote.id;
    // if isPinned is changed update the note and also update HomePage
    bool _shouldUpdateHomePage = false;
    if (currentNote.isPinned != isPinned) {
      _shouldUpdateHomePage = true;
    }
    // update note
    await context.read(NoteProvider(currentNote.id)).update(newNote);
    
    // setPin() and unsetPin methods will update the homepage if it should be updated
    if (_shouldUpdateHomePage && isPinned == 1) {
      context.read(NoteListViewModelProvider).setPin([newNote]);
    } else if (_shouldUpdateHomePage && isPinned == 0) {
      context.read(NoteListViewModelProvider).unsetPin([newNote]);
    }
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
