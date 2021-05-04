import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/widgets/note_card.dart';
import 'package:notes/providers/providers.dart';

class NotesList extends StatelessWidget {
  String page;
  NotesList({this.page});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        AsyncValue<List<Note>> asyncnotelist = page == 'home'
            ? watch(AllNotesProvider)
            : watch(AllSearchResultProvider);

        return asyncnotelist.when(
          data: (data) {
            // This [Padding] affects the area between the edge of the screen and the [ListView]
            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (contex, index) {
                    return NoteCard(
                      id: data[index].id,
                      page: page,
                    );
                  },
                  childCount: data?.length ?? 0,
                ),
              ),
            );
          },
          loading: () {
            return SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()));
          },
          error: (errr, stack) =>
              SliverFillRemaining(child: const Text('error')),
        );
      },
    );
  }
}
