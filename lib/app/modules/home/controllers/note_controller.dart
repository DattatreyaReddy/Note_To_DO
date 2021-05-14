import 'dart:async';

import 'package:get/get.dart';

import '../../../data/note_model.dart';
import '../../../data/providers/note_provider.dart';
import '../../../data/repository/note_repository.dart';

class NoteController extends GetxController {


  NoteRepository _noteRepository = NoteRepository(NoteProvider.instance);

  RxBool isEmptyTitle = false.obs;
  RxBool isEmptyDescription = false.obs;

  RxList<Note> notes = <Note>[].obs;

  Future<void> reloadNotes() async {
    notes.clear();
    notes.addAll(await _noteRepository.queryAll());
  }

  Future<void> removeNote(Note note) async {
    notes.remove(note);
    _noteRepository.delete(note);
  }

  Future<void> addNote(Note note) async {
    note.id = await _noteRepository.insert(note);
    notes.add(note);
  }

  FutureOr<int> updateNote(Note note) async {
    await _noteRepository.update(note);
    reloadNotes();
    return note.id!;
  }

  @override
  void onInit() {
    reloadNotes();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
