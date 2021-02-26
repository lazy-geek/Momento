import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/models/note.dart';
import 'package:notes/view_model/note_list_view_model.dart';
import 'package:notes/models/selected_notes.dart';
// The [NoteListViewModelProvider] provides an instance of [NoteListViewModel] class.
final NoteListViewModelProvider =
    ChangeNotifierProvider<NoteListViewModel>((ref) => NoteListViewModel());

// The [AllNotesProvider] fetches Notes List from [NoteListViewModel] class 
// using the [NoteListViewModelProvider] and provides the Notes List.
// note: we use [FutureProvider] becouse =>
// 1. we need to await for getAllNotes() to be completed.
// 2. we get benifit of using .when() with [AsyncValue] , so we don't need [FutureBuilder]
final AllNotesProvider = FutureProvider<List<Note>>((ref) async {
  await ref.watch(NoteListViewModelProvider).getAllNotes();
  return ref.watch(NoteListViewModelProvider).notes_list;
});

// The [ScrollControllerProvider] provides an instance of [ScrollController] class.
// here we used simple Provider becouse we only need to provide and read the class and
// don't need to listen to it.
final ScrollControllerProvider =
    Provider<ScrollController>((ref) => ScrollController());

// The [NoteProvider] takes an index of the Note and fetches the Note
// from Note List Provided by [AllNotesProvider] class.
final NoteProvider = ChangeNotifierProvider.family<Note, int>((ref, index) {
  return ref.watch(AllNotesProvider).data.value[index];
});

// the [SelectedNotesProvider] provides SelectedNotes ChangeNotifier
// which we can listen to in order to get currently selected notes
final SelectedNotesProvider = ChangeNotifierProvider<SelectedNotes>((ref) => new SelectedNotes());
