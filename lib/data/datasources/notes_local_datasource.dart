import 'package:flutterhw38/data/models/note_model.dart';

class NotesLocalDataSource {
  List<NoteModel> _cache = [];

  Future<void> cacheNotes(List<NoteModel> notes) async {
    _cache = notes;
  }

  Future<List<NoteModel>> getCachedNotes() async {
    return _cache;
  }
}