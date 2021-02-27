import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/widgets/note_card.dart';
import 'package:notes/providers/providers.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        AsyncValue asyncnotelist = watch(AllNotesProvider);
        return asyncnotelist.when(
          data: (data) {
            return CustomScrollView(
              controller: context.read(ScrollControllerProvider),
              slivers: [
                // This [Padding] affects the area between the edge of the screen and the [ListView]
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (contex, index) {
                        return NoteCard(index: index);
                      },
                      childCount: data?.length ?? 0,
                    ),
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
  }
}
