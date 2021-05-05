import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/pages/addNotePage.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';
import 'package:notes/widgets/fab.dart';
import 'package:notes/widgets/notes_grid.dart';
import 'package:notes/widgets/notes_list.dart';
import 'package:notes/widgets/searchBar.dart';
import 'package:page_transition/page_transition.dart';

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
            SearchBar(),
            Consumer(
              builder: (context, watch, child) {
                LayoutType layout = watch(NoteListViewModelProvider).layout;
                return layout == LayoutType.Grid
                    ? NotesGrid(
                        page: 'home',
                      )
                    : NotesList(page: 'home');
              },
            ),
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
