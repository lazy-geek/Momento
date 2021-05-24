import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';
import 'package:notes/widgets/contextual_appbar.dart';
import 'package:notes/widgets/notes_grid.dart';
import 'package:notes/widgets/notes_list.dart';
import 'package:notes/widgets/searchBar.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String txt;
  @override
  void initState() {
    super.initState();
    txt = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF293440),
      backgroundColor: Color(0xFF212736),
      // appBar: AppBar(
      //   title: const Text('Notes'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          slivers: [
            // there is a bug in flutter which causes app to crash if the first widget
            // in [CustomScrollView] is not a sliver i.e. [Consumer] thats why here first
            // widget is [SliverToBoxAdapter].
            SliverToBoxAdapter(),

            Consumer(
              builder: (context, watch, child) {
                final selectednotes = watch(SelectedNotesProvider);
                // [isSelected] will be true if any notes are selected
                bool isSelected = selectednotes.notes_list.isNotEmpty;
//                return SliverAnimatedSwitcher(
//                  child: isSelected
//                      ? ContextualAppBar()
//                      : SearchBar(
//                          onTextChanged: (val) {
//                            setState(() {
//                              txt = val;
//                            });
//                          },
//                        ),
//                  duration: Duration(milliseconds: 200),
//                );
                return SliverStack(
                  children: [
                    SliverOffstage(
                      offstage: isSelected,
                      sliver: SearchBar(
                        onTextChanged: (val) {
                          setState(() {
                            txt = val;
                          });
                        },
                      ),
                    ),
                    if (isSelected) ContextualAppBar()
                  ],
                );
              },
            ),
            txt.isNotEmpty
                ? (context.read(NoteListViewModelProvider).layout ==
                        LayoutType.Grid
                    ? NotesGrid(
                        page: 'search',
                      )
                    : NotesList(
                        page: 'search',
                      ))
                : SliverToBoxAdapter(
                    child: Container(),
                  ),
          ],
        ),
      ),
    );
  }
}
