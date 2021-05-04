import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/widgets/note_card.dart';
import 'package:notes/providers/providers.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        AsyncValue asyncnotelist = watch(AllNotesProvider);

        return asyncnotelist.when(
          data: (data) {
            // This [Padding] affects the area between the edge of the screen and the [ListView]
            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (contex, index) {
                    return NoteCard(
                      index: index,
                      page: 'home',
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
