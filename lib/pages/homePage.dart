import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/pages/addNotePage.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';
import 'package:notes/widgets/fab.dart';
import 'package:notes/widgets/notes_grid.dart';
import 'package:notes/widgets/notes_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
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
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      viewModel.deleteMultipleNotes(
                          selectednotes.notes_list.map((e) => e.id).toList());
                      selectednotes.clear();
                    });
              } else {
                // if no notes are selected and the current layout is Grid then Show the List Icon.
                if (layout == LayoutType.Grid) {
                  return IconButton(
                    icon: Icon(Icons.list),
                    onPressed: () {
                      viewModel.toggleView();
                    },
                  );
                } else {
                  // if current layout is List then Show the Grid Icon
                  return IconButton(
                    icon: Icon(Icons.grid_view),
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
        backgroundColor: Color(0xFF293440),
      ),
      // Dark Mode color
      backgroundColor: Color(0xFF293440),
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
            MaterialPageRoute(
              builder: (context) => AddNotePage(),
            ),
          );
        },
      ),
    );
  }
}
