import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/providers/providers.dart';

class ContextualAppBar extends StatefulWidget {
  @override
  _ContextualAppBarState createState() => _ContextualAppBarState();
}

class _ContextualAppBarState extends State<ContextualAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF303645),
      leadingWidth: 100,
      leading: Row(
        children: [
          IconButton(
            icon: Icon(Icons.clear,),
            onPressed: () {
              context.read(SelectedNotesProvider).clear();
            },
          ),
          SizedBox(
            width: 5.0,
          ),
          Consumer(builder: (context, watch, child) {
            
            final selectednotes = watch(SelectedNotesProvider);
            final count = selectednotes.notes_list.length;
            return Text(
              '$count',
              style: TextStyle(
                fontSize: 23.0,
              ),
            );
          }),
        ],
      ),
      // toolbarHeight: 71.0,
      actions: [
        IconButton(
          icon: Icon(Icons.push_pin_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            context.read(NoteListViewModelProvider).deleteMultipleNotes(context
                .read(SelectedNotesProvider)
                .notes_list
                .map((e) => e.id)
                .toList());
            context.read(SelectedNotesProvider).clear();
          },
        ),
      ],
    );
  }
}
