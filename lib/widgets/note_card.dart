import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/editNotePage.dart';

class NoteCard extends StatefulWidget {
  Note currentNote;
  NoteCard({this.currentNote});
  @override
  _NoteCardState createState() => _NoteCardState();
}

// padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
// padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    // TODO : impement inkwell instead of GestureDetector
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditNotePage(
              currentNote: widget.currentNote,
            ),
          ),
        );
      },
      child: Container(
        // use [margin] property only if using list layout , don't use it with grid layout
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            // color: Colors.white,
            color: Color(0xFF2c3342),
            borderRadius: BorderRadius.circular(10.0),
            border:
                Border.all(width: 1.0, color: Colors.grey.withOpacity(0.2))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.currentNote.title.isNotEmpty
                ? Padding(
                    // padding:const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 7.0),
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      "${widget.currentNote.title}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                  )
                : Container(
                    height: 0.0,
                    width: 0.0,
                  ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              // padding: const EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 8.0),
              padding: EdgeInsets.all(0.0),
              child: Text(
                "${widget.currentNote.content}",
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: TextStyle(
                  // height: 1.3,
                  fontSize: 16.0,
                  // light mode
                  // color: Colors.grey.shade600

                  //dark mode
                  color: Colors.white.withOpacity(0.8),
                  // color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
