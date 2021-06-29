import 'package:flutter/material.dart';
import 'package:notes/business_logic/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/utils/app_colors.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController t1;
  @override
  void initState() {
    super.initState();
    t1 = TextEditingController();
    // update the state of [SearchTextProvider] every time text of
    // [TextField] changes
    t1.addListener(() {
      context.read(SearchTextProvider).state = t1.text.toLowerCase();
    });
  }

  @override
  void dispose() {
    t1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        Consumer(
          builder: (context, watch, child) {
            String txt = watch(SearchTextProvider).state;
            if (txt.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  t1.clear();
                },
              );
            } else {
              return Container();
            }
          },
        )
      ],
      backgroundColor: kAppBarColor,
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                hintText: 'Search your notes',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Open Sans',
                ),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
