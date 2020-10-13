import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/view_model/note_list_view_model.dart';
import 'package:notes/widgets/note_card.dart';

class NotesList extends StatefulWidget {
  ScrollController s;
  NotesList({this.s});
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  NoteListViewModel noteListViewModel;
  @override
  void initState() {
    super.initState();
    noteListViewModel = NoteListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: noteListViewModel.getAllNotes(),
      builder: (context, AsyncSnapshot<List<Note>> snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(physics: BouncingScrollPhysics(),
          controller: widget.s,
          itemCount: snapshot.data.length ?? 0,
          itemBuilder: (context, index) {
            return NoteCard(currentNote: snapshot.data[index]);
          },
        );
      },
    );
  }
}
