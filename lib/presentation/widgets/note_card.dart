import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/data/models/note.dart';
import 'package:notes/presentation/pages/edit_note_page.dart';
import 'package:notes/business_logic/providers/providers.dart';
import 'package:notes/presentation/pages/search_page.dart';
import 'package:notes/utils/app_colors.dart';
import 'package:notes/utils/helper_functions.dart';
import 'package:notes/data/repositories/notes_repository.dart';
import 'package:notes/presentation/pages/home_page.dart';

class NoteCard extends StatefulWidget {
  final int id;
  final String page;
  NoteCard({this.page, this.id});

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    // we use [Consumer] here in order to minimize the rebuild by only rebuilding this
    // instance [NoteCard] when this Note changes, using the [NoteProvider] as oppose to
    // rebuilding the whole listview or gridview which happens in the case where
    // the current Note was provided from [AllNotesProvider] which causes the whole list rebuild
    // whenever a single Note changes because [AllNotesProvider] provies the note list, not a single note.
    return Consumer(
      builder: (context, watch, child) {
        // print('inside note card at index ${widget.index}');
        Note note = watch(NoteProvider(widget.id));
        final viewModel = watch(NotesRepositoryProvider);
        LayoutType layout = viewModel.layout;

        final selectednotes = watch(SelectedNotesProvider);

        // [isSelected] will be true if current note is selected
        bool isSelected = selectednotes.notes_list.contains(note);
        return Hero(
          tag: widget.id.toString() + widget.page.toString(),
          transitionOnUserGestures: true,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              // use [margin] property only if using list layout , don't use it with grid layout
              margin: layout == LayoutType.List
                  ? const EdgeInsets.only(bottom: 9.0)
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
                    : Border.all(
                        width: 1.2,
                        // color: Colors.grey.withAlpha(80),
                        // color: Color(0xFF323d4e),

                        // color: Color(0xFF343b4b),
                        color: Color(0xFF3f475a),
                      ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kCardColor,
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
                    } else if (selectednotes.notes_list.isNotEmpty) {
                      // if current note is not selected but any of the other note is selected
                      // then select the current note when user presses on it by adding it to the selectednotes list
                      selectednotes.add(note);
                    } else {
                      bool shouldShowSnackBar = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNotePage(
                            id: widget.id,
                            page: widget.page,
                          ),
                        ),
                      );
                      if (shouldShowSnackBar == true) {
                        if (widget.page == "search") {
                          emptyNoteDiscardedFlushbar
                            ..show(searchPageScaffoldkey.currentContext);
                        } else {
                          emptyNoteDiscardedFlushbar
                            ..show(homePageScaffoldkey.currentContext);
                        }
                      }
                    }
                  },
                  onLongPress: () {
                    // select the note on long press
                    if (isSelected) {
                      selectednotes.remove(note);
                      return;
                    }
                    selectednotes.add(note);
                  },
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 15.0, bottom: 0.0, left: 15.0),
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
                                        // fontFamily: 'Open Sans',
                                        // fontFamily: 'Roboto Mono',
                                        // fontWeight: FontWeight.w500,
                                        // wordSpacing: -5,
                                        fontFamily: 'Roboto',
                                        // fontFamily: 'Noto Sans',
                                        fontSize: 18.0,
                                        color: Colors.white),
                                  ),
                                )
                              : Container(
                                  height: 0.0,
                                  width: 0.0,
                                ),
                          _applySpacing(note.title, note.content),
                          note.content.isNotEmpty
                              ? Padding(
                                  // padding: const EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 8.0),
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Text(
                                    "${note.content}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        // fontFamily: 'Open Sans',
                                        fontFamily: 'Roboto'
                                        // fontFamily: 'Roboto Mono',
                                        // wordSpacing: -5,
                                        // fontFamily: 'Nato Sans'
                                        ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
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

Widget _applySpacing(String title, String content) {
  if (title.isNotEmpty && content.isNotEmpty) {
    return SizedBox(
      height: 10.0,
    );
  } else if (title.isNotEmpty && content.isEmpty) {
    return SizedBox(
      height: 15.0,
    );
  } else {
    return SizedBox(
      height: 0.0,
    );
  }
}