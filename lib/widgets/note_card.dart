import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/editNotePage.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';

class NoteCard extends StatefulWidget {
  final int index;

  NoteCard({this.index});

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  // [isSelected] will be true if current note is selected
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
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
        LayoutType layout = viewModel.layout;

        final selectednotes = context.read(SelectedNotesProvider);
        return Hero(
          tag: widget.index,
          transitionOnUserGestures: true,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              // use [margin] property only if using list layout , don't use it with grid layout
              margin: layout == LayoutType.List
                  ? const EdgeInsets.symmetric(vertical: 5.0)
                  : null,
              // the reason i used [foregroundDecoration] instead of simple [Decoration] property is that
              // the [foregroundDecoration] property draws the decoration on top of the Container so
              // it doesn't interfear with spacing and layout of the nearby [NoteCard] widgets in the grid or list
              // if we used simple [Decoration] properrty then when ever we select the widget and the Container's
              // border are drawn then the surrounding widgets get pushed by some pixels
              foregroundDecoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.08) : null,
                border: isSelected
                    ? Border.all(
                        width: 1.8,
                        color: Colors.white,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFF354252),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  enableFeedback: true,
                  onTap: () async {
                    // check if current or any of the notes in the list is selected
                    // if current note is selected and user presses on it , then deselect it
                    // by removing it from the selectednotes list
                    if (isSelected) {
                      selectednotes.remove(note);
                      setState(() {
                        isSelected = false;
                      });
                    } else if (selectednotes.notes_list.isNotEmpty) {
                      // if current note is not selected but any of the other note is selected
                      // then select the current note when user presses on it by adding it to the selectednotes list
                      selectednotes.add(note);
                      setState(() {
                        isSelected = true;
                      });
                    } else {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNotePage(
                            index: widget.index,
                          ),
                        ),
                      );
                    }
                  },
                  onLongPress: () {
                    // select the note on long press
                    if (isSelected) {
                      selectednotes.remove(note);
                      setState(() {
                        isSelected = false;
                      });
                      return;
                    }
                    selectednotes.add(note);
                    setState(() {
                      isSelected = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        note.title.isNotEmpty
                            ? Padding(
                                // padding:const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 7.0),
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  "${note.title}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
                              )
                            : Container(
                                height: 0.0,
                                width: 0.0,
                              ),
                        if (note.content.isNotEmpty)
                          const SizedBox(
                            height: 10.0,
                          ),
                        Padding(
                          // padding: const EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 8.0),
                          padding: const EdgeInsets.all(0.0),
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
