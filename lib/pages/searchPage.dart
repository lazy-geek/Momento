import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/widgets/note_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String str;
  TextEditingController t1;
  List<Note> filteredNotes = [];
  @override
  void initState() {
    super.initState();
    t1 = TextEditingController();
    str = "";
    filteredNotes = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF293440),
      // appBar: AppBar(
      //   title: const Text('Notes'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                t1.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            t1.text = "";
                            filteredNotes = [];
                          });
                        },
                      )
                    : Container()
              ],
              backgroundColor: Color(0xFF293440),
              forceElevated: true,
              title: Hero(
                tag: 'searchbar',
                transitionOnUserGestures: true,
                child: Material(
                  type: MaterialType.transparency,
                  child: TextField(
                    autofocus: true,
                    controller: t1,
                    toolbarOptions: ToolbarOptions(
                        copy: true, cut: true, paste: true, selectAll: true),
                    onChanged: (val) {
                      setState(() {
                        filteredNotes = searchNotes(val.toLowerCase(), context);
                      });
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 18.0),
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        hintText: 'Search your notes',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            SliverPadding(
              // This [Padding] affects the area between the edge of the screen and the [StaggeredGridView]
              padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
              sliver: SliverStaggeredGrid.countBuilder(
                // The [crossAxisSpacing] and [mainAxisSpacing] affects the area the between Grid Items
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0,
                itemCount: filteredNotes?.length ?? 0,
                staggeredTileBuilder: (index) {
                  return const StaggeredTile.fit(1);
                },
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return NoteCard(
                    index: filteredNotes[index].id - 1,
                    page: 'search',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Note> searchNotes(String str, BuildContext context) {
  List<Note> notes = context.read(NoteListViewModelProvider).notes_list;

  List<Note> notes_filtered = [];
  str = str.trim();
  if (str.isEmpty) return [];

  List<String> searchwords = str.split(" ").toList();
  notes.forEach((element) {
    bool flag = searchwords.every((word) {
      return (element.content.toLowerCase().contains(word) ||
          element.title.toLowerCase().contains(word));
    });
    if (flag && !notes_filtered.contains(element)) notes_filtered.add(element);
  });

  return notes_filtered;
}
