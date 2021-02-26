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
              LayoutType layout = viewModel.layout;
              if (layout == LayoutType.Grid) {
                return IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    viewModel.toggleView();
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.grid_view),
                  onPressed: () {
                    viewModel.toggleView();
                  },
                );
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
