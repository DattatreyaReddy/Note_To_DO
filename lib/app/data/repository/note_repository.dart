import 'dart:async';

import '../note_model.dart';
import '../providers/note_provider.dart';

class NoteRepository {
  final NoteProvider _noteProvider;

  NoteRepository(this._noteProvider);

  Future<int> insert(Note note) {
    return _noteProvider.insert(note.toJson());
  }

  FutureOr<List<Note>> queryAll() async {
    List<Note> noteList = [];
    List<Map<String, dynamic>> queryList = await _noteProvider.queryAll();
    queryList.forEach((element) => noteList.add(Note.fromJson(element)));
    return noteList;
  }

  Future<int> update(Note note) async {
    // It Returns Noof Updates Made
    return await _noteProvider.update(note.toJson());
  }

  Future<int> delete(Note note) async {
    return await _noteProvider.delete(note.toJson());
  }
}
