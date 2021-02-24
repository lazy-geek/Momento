import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/view_model/note_list_view_model.dart';

final NoteListViewModelProvider =
    ChangeNotifierProvider<NoteListViewModel>((ref) => NoteListViewModel());


final AllNotesProvider = FutureProvider<List<Note>>((ref) async {
 await ref.watch(NoteListViewModelProvider).getAllNotes();
 return ref.watch(NoteListViewModelProvider).notes_list;
});