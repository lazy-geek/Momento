import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/pages/searchPage.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/view_model/note_list_view_model.dart';

class MainAppBar extends StatefulWidget {
  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      floating: true,
      snap: true,
      primary: false,
      elevation: 0.0,
      toolbarHeight: 71.0,

      // centerTitle: true,
      // forceElevated: true,
      automaticallyImplyLeading: false,
      // backgroundColor: Color(0xFF354252),
      backgroundColor: Colors.transparent,
      title: Column(
        children: [
          SizedBox(
            height: 5.0,
          ),
          Card(
            // elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // color: Color(0xFF2a313c),
            //  color: Color(0xFF303845),
            color: Color(0xFF303645),
            //  color: Color(0xFF2e3444),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // color: Color(0xFF2a313c),
                // color: Color(0xFF303845),
                color: Color(0xFF303645),
                //  color: Color(0xFF2e3444),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Hero(
                          tag: 'searchbar',
                          transitionOnUserGestures: true,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              'Search your notes',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                      ),
                      Consumer(
                        builder: (context, watch, child) {
                          final viewModel = watch(NoteListViewModelProvider);
                          // layout variable is used to determine currently slected layout
                          LayoutType layout = viewModel.layout;
                          if (layout == LayoutType.Grid) {
                            return IconButton(
                              iconSize: 30.0,
                              icon: const Icon(Icons.list),
                              onPressed: () {
                                viewModel.toggleView();
                              },
                            );
                          } else {
                            // if current layout is List then Show the Grid Icon
                            return IconButton(
                              // iconSize: 30.0,
                              icon: const Icon(
                                Icons.grid_view,
                              ),
                              onPressed: () {
                                viewModel.toggleView();
                              },
                            );
                          }
                          // }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
