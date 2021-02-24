import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/models/note.dart';
import 'package:notes/view_model/note_list_view_model.dart';
import 'package:notes/widgets/note_card.dart';

class NotesGrid extends StatefulWidget {
  @override
  _NotesGridState createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
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

        return CustomScrollView(
          slivers: [
            SliverPadding(
              // This [Padding] affects the area between the edge of the screen and the [StaggeredGridView]
              padding: EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
              sliver: SliverStaggeredGrid.countBuilder(
                // The [crossAxisSpacing] and [mainAxisSpacing] affects the area the between Grid Items
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                staggeredTileBuilder: (index) {
                  return StaggeredTile.fit(1);
                },
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return NoteCard(currentNote: snapshot.data[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
