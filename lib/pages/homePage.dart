import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/addNotePage.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';
import 'package:notes/widgets/contextual_appbar.dart';
import 'package:notes/widgets/fab.dart';
import 'package:notes/widgets/notes_grid.dart';
import 'package:notes/widgets/notes_list.dart';
import 'package:notes/widgets/mainAppBar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF293440),
      // backgroundColor: const Color(0xFF252B34),

      // backgroundColor: const Color(0xFF232834),
      // backgroundColor: Color(0xFF242833),
      backgroundColor: Color(0xFF212736),

      // backgroundColor: const Color(0xFF212936),
      // backgroundColor: const Color(0xFF242c38),

      // backgroundColor: const Color(0xFF2a313c),
      body: SafeArea(
        child: CustomScrollView(
//          physics: BouncingScrollPhysics(),
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
//                    child: isSelected
//                        ? MultiSliver(children: [
//                            ContextualAppBar(),
//                            SizedBox(
//                              height: 15.0,
//                            ),
//                          ])
//                        : MainAppBar(),
//                    duration: Duration(milliseconds: 200));
                return SliverStack(
                  children: [
                    SliverOffstage(offstage: isSelected, sliver: MainAppBar()),
                    if (isSelected)
                      MultiSliver(children: [
                        ContextualAppBar(),
                        SizedBox(
                          height: 15.0,
                        ),
                      ])
                  ],
                );
              },
            ),
            buildPinnedLable(context),
            buildPinnedNotes(context),
            buildUnPinnedLable(context),
            buildUnPinnedNotes(context),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 70.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Fab(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                // type: PageTransitionType.scale,
                // child: AddNotePage(),
                // duration: Duration(milliseconds: 200),
                // alignment: Alignment.bottomRight,
                // curve: Curves.easeInOutCubic),

                //   type: PageTransitionType.rightToLeft,
                //   child: AddNotePage(),
                //   duration: Duration(milliseconds: 200),curve: Curves.easeInOutCubic

                type: PageTransitionType.rightToLeft,
                child: AddNotePage(),
                duration: Duration(milliseconds: 200),
                reverseDuration: Duration(milliseconds: 200),
                // alignment: Alignment.bottomRight,
                curve: Curves.easeInOutCubic),
          );
        },
      ),
    );
  }
}

Widget buildPinnedNotes(BuildContext context) {
  return Consumer(
    builder: (context, watch, child) {
      LayoutType layout = watch(NoteListViewModelProvider).layout;
      return layout == LayoutType.Grid
          ? NotesGrid(
              page: 'home',
              type: 'pinned',
            )
          : NotesList(
              page: 'home',
              type: 'pinned',
            );
    },
  );
}


Widget buildUnPinnedNotes(BuildContext context) {
  return Consumer(
    builder: (context, watch, child) {
      LayoutType layout = watch(NoteListViewModelProvider).layout;
      return layout == LayoutType.Grid
          ? NotesGrid(
              page: 'home',
              type: 'unpinned',
            )
          : NotesList(
              page: 'home',
              type: 'unpinned',
            );
    },
  );
}
Widget buildPinnedLable(BuildContext context) {
  return Consumer(
    builder: (context, watch, child) {
      AsyncValue<List<Note>> asyncnotelist = watch(AllNotesProvider);
      return asyncnotelist.when(
        data: (allnotes) {
          var pinnedcount = 0,unpinnedcount = 0;
          allnotes.forEach((element) {
            if(element.isPinned == 1) {
              pinnedcount++;
            }
            else{
              unpinnedcount++;
            }
          });
          if (pinnedcount > 0) {
            return SliverPadding(
              padding: EdgeInsets.only(top: 25.0, left: 20.0, bottom: 25),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'PINNED',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            );
          } else {
            return SliverToBoxAdapter(
            );
          }
        },
        error: (Object error, StackTrace stackTrace) {
          return SliverToBoxAdapter();
        },
        loading: () {
          return SliverToBoxAdapter();
        },
      );
    },
  );
}


Widget buildUnPinnedLable(BuildContext context) {
  return Consumer(
    builder: (context, watch, child) {
      AsyncValue<List<Note>> asyncnotelist = watch(AllNotesProvider);

      return asyncnotelist.when(
        data: (allnotes) {
          var pinnedcount = 0,unpinnedcount = 0;
          allnotes.forEach((element) {
            if(element.isPinned == 1) {
              pinnedcount++;
            }
            else{
              unpinnedcount++;
            }
          });
          if ( unpinnedcount > 0 && pinnedcount >0) {
            return SliverPadding(
              padding: EdgeInsets.only(top: 25.0, left: 20.0, bottom: 25),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'OTHERS',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            );
          } else {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            );
          }
        },
        error: (Object error, StackTrace stackTrace) {
          return SliverToBoxAdapter();
        },
        loading: () {
          return SliverToBoxAdapter();
        },
      );
    },
  );
}