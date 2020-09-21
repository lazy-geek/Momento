import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/editNotePage.dart';
import 'package:notes/view_model/note_list_view_model.dart';

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
    return ListView.builder(controller: widget.s,
      itemCount: snapshot.data.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
        builder: (context) => EditNotePage(
              currentNote: snapshot.data[index],
            ))).then((value) {
                if (value) {
                  setState(() {});
                }
              });
              
            },
              key: ValueKey(snapshot.data[index].id),
              title: Text("${snapshot.data[index].title}"),
              subtitle: Text("${snapshot.data[index].id}"),
            );
      },
    );
        },
      );
  }
}
