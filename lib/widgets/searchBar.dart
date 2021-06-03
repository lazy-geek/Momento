import 'package:flutter/material.dart';
import 'package:notes/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/utils/constants.dart';

class SearchBar extends StatefulWidget {
  final Function onTextChanged;
  SearchBar({this.onTextChanged});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController t1;
  @override
  void initState() {
    super.initState();
    t1 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        t1.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    t1.text = "";
                    context.read(SearchResultClassProvider).get("");
                  });
                },
              )
            : Container()
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
            onChanged: (val) {
              setState(() {
                widget.onTextChanged(val);
                context.read(SearchResultClassProvider).get(val.toLowerCase());
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
    );
  }
}
