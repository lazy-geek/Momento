import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/providers.dart';

class SearchResult extends ChangeNotifier {
  ProviderReference ref;
  SearchResult(this.ref);
  List<Note> notes_list = [];

  void get(String str) {
    List<Note> notes = ref.watch(NoteListViewModelProvider).notes_list;

    List<Note> notes_filtered = [];
    str = str.trim();
    if (str.isEmpty || notes == null) {
      notes_list = [];
      notifyListeners();
      return;
    }

    List<String> searchwords = str.split(" ").toList();
    notes.forEach((element) {
      bool flag = searchwords.every((word) {
        return (element.content.toLowerCase().contains(word) ||
            element.title.toLowerCase().contains(word));
      });
      if (flag && !notes_filtered.contains(element))
        notes_filtered.add(element);
    });

    notes_filtered.forEach((element) {
      print('filtered note' + element.id.toString() + ' ' + element.title);
    });
    notes_list = notes_filtered;

    notifyListeners();
  }
}
