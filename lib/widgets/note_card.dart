import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/editNotePage.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';

class NoteCard extends StatefulWidget {
  int index;
  NoteCard({this.index});
  @override
  _NoteCardState createState() => _NoteCardState();
}

// padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
// padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    // TODO : impement inkwell instead of GestureDetector

    // we use [Consumer] here in order to minimize the rebuild by only rebuilding this
    // instance [NoteCard] when this Note changes, using the [NoteProvider] as oppose to
    // rebuilding the whole listview or gridview which happens in the case where
    // the current Note was provided from [AllNotesProvider] which causes the whole list rebuild
    // whenever a single Note changes because [AllNotesProvider] provies the note list, not a single note.
    return Consumer(
      builder: (context, watch, child) {
        print('inside note card at index ${widget.index}');
        Note note = watch(NoteProvider(widget.index));
        final viewModel = watch(NoteListViewModelProvider);
        ViewType v = viewModel.v;
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNotePage(
                  index: widget.index,
                ),
              ),
            );
          },
          child: Container(
            // use [margin] property only if using list layout , don't use it with grid layout
            margin: v== ViewType.List? EdgeInsets.symmetric(vertical: 5.0) : EdgeInsets.symmetric(vertical:0.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              //   boxShadow: [
              //   BoxShadow(color: Color(0xFF2c3342).withOpacity(0.8),blurRadius: 1.0,offset: Offset(-4.0,4.0)),
              //   BoxShadow(color: Color(0xFF2c3342).withOpacity(0.8),blurRadius: 1.0,offset: Offset(4.0,-4.0))
              // ],
              // color: Colors.white,
              color: Color(0xFF354252),
              borderRadius: BorderRadius.circular(10.0),
              // border: Border.all(
              //   width: 1.0,
              //   color: Colors.grey.withOpacity(0.2),
              // ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                note.title.isNotEmpty
                    ? Padding(
                        // padding:const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 7.0),
                        padding: EdgeInsets.all(0.0),
                        child: Text(
                          "${note.title}",
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
                    "${note.content}",
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
      },
    );
  }
}
