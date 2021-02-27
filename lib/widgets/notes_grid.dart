import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/widgets/note_card.dart';

class NotesGrid extends StatefulWidget {
  @override
  _NotesGridState createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        AsyncValue asyncnotelist = watch(AllNotesProvider);
        return asyncnotelist.when(
          data: (data) {
            return CustomScrollView(
              controller: context.read(ScrollControllerProvider),
              semanticChildCount: data?.length ?? 0,
              shrinkWrap: true,
              slivers: [
                SliverPadding(
                  // This [Padding] affects the area between the edge of the screen and the [StaggeredGridView]
                  padding: EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                  sliver: SliverStaggeredGrid.countBuilder(
                    // The [crossAxisSpacing] and [mainAxisSpacing] affects the area the between Grid Items
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 9.0,
                    itemCount: data?.length ?? 0,
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.fit(1);
                    },
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      return NoteCard(index: index);
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (errr, stack) => Text('error'),
        );
      },
    );
    // AsyncValue<List<Note>> notelist = watch(AllNotesProvider);
  }
}
