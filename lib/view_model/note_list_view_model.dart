import 'package:flutter/foundation.dart';
import 'package:notes/models/note.dart';
import 'package:notes/utils/databaseHelper.dart';

class NoteListViewModel extends ChangeNotifier {
  List<Note> notes_list;
  NoteListViewModel() {
    this.notes_list = [];
  }

  Future<int> addNote(Note note) async {
    var result = await DatabaseHelper.instance.addNote(note);
    // await getAllNotes();
    notifyListeners();
    return result;
  }

  Future<void> getAllNotes() async {
    notes_list = await DatabaseHelper.instance.getAllNotes();
    print(notes_list.last.content);

    notifyListeners();//  if(notes_list == null) return [];
  }

  Future<Note> getNote(int noteId) async {
    return notes_list.map((element) {
      if (element.id == noteId) {
        return element;
      }
    }).first;
  }

  Future<int> deleteNote(int noteid) async {
    var result = await DatabaseHelper.instance.deleteNote(noteid);
    // await getAllNotes();
    notifyListeners();
    return result;
  }

  Future<int> updateNote(Note note) async {
    var result = await DatabaseHelper.instance.updateNote(note);
    notes_list = await DatabaseHelper.instance.getAllNotes();
    notifyListeners();
    return result;
  }
}
