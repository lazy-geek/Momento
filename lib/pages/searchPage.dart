import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/providers/providers.dart';
import 'package:notes/widgets/notes_grid.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController t1;
  @override
  void initState() {
    super.initState();
    t1 = TextEditingController();
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
            SliverAppBar(
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
              // backgroundColor: Color(0xFF293440),
              backgroundColor: Color(0xFF303645),
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
                        context
                            .read(SearchResultClassProvider)
                            .get(val.toLowerCase());
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
            t1.text.isNotEmpty
                ? NotesGrid(
                    page: 'search',
                  )
                : SliverToBoxAdapter(
                    child: Container(),
                  ),
          ],
        ),
      ),
    );
  }
}
