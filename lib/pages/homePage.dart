import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/pages/addNotePage.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';
import 'package:notes/widgets/fab.dart';
import 'package:notes/widgets/notes_grid.dart';
import 'package:notes/widgets/notes_list.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, watch, child) {
              final viewModel = watch(NoteListViewModelProvider);
              // layout variable is used to determine currently slected layout
              LayoutType layout = viewModel.layout;

              final selectednotes = watch(SelectedNotesProvider);
              // [isSelected] will be true if any notes are selected
              bool isSelected = selectednotes.notes_list.isNotEmpty;
              // if any notes are selected show delete icon
              if (isSelected) {
                return IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      viewModel.deleteMultipleNotes(
                          selectednotes.notes_list.map((e) => e.id).toList());
                      selectednotes.clear();
                    });
              } else {
                // if no notes are selected and the current layout is Grid then Show the List Icon.
                if (layout == LayoutType.Grid) {
                  return IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: () {
                      viewModel.toggleView();
                    },
                  );
                } else {
                  // if current layout is List then Show the Grid Icon
                  return IconButton(
                    icon: const Icon(Icons.grid_view),
                    onPressed: () {
                      viewModel.toggleView();
                    },
                  );
                }
              }
            },
          ),
        ],
        // Dark Mode color
        backgroundColor: const Color(0xFF293440),
      ),
      // Dark Mode color
      backgroundColor: const Color(0xFF293440),
      // body: NotesList(),
      body: Consumer(
        builder: (context, watch, child) {
          LayoutType layout = watch(NoteListViewModelProvider).layout;
          return layout == LayoutType.Grid ? NotesGrid() : NotesList();
        },
      ),
      floatingActionButton: Fab(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.scale,
              child: AddNotePage(),
              duration: Duration(milliseconds: 200),alignment: Alignment.bottomRight,curve: Curves.easeOut
            ),
            // PageTransition(
            //   type: PageTransitionType.rightToLeft,
            //   child: AddNotePage(),
            //   duration: Duration(milliseconds: 400),curve: Curves.fastOutSlowIn
            // ),
          );
        },
      ),
    );
  }
}
