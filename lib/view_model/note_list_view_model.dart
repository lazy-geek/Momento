import 'package:notes/models/note.dart';
import 'package:notes/utils/databaseHelper.dart';
class NoteListViewModel{
List<Note> notes_list = [];
bool isLoading = false;

Future<int> addNote(Note note) async {
    var result = await DatabaseHelper.instance.addNote(note);
    await getAllNotes();
    return result;
  }

Future<List<Note>> getAllNotes() async {
  if(notes_list.isEmpty)
  {
     notes_list = await DatabaseHelper.instance.getAllNotes();
  }
  return notes_list;
  }

Future<Note> getNote(int noteId) async {
    return notes_list.map((element) {
      
      if(int.parse(element.id) == noteId){
        return element;
      }
      }).first;
  }

Future<int> deleteNote(int noteid) async {
    var result = await DatabaseHelper.instance.deleteNote(noteid);
    await getAllNotes();
    return result;
  }

Future<int> updateNote(Note note) async {
    var result = await DatabaseHelper.instance.updateNote(note);
    await getAllNotes();
    return result;
  }
}