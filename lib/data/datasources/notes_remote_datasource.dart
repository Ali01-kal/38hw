import 'package:flutterhw38/data/models/note_model.dart';

class NotesRemoteDataSource {
  Future<List<NoteModel>> fetchNotes() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      {"id": 1, "title": "API Note", "content": "From server"},
      {"id": null, "title": null, "content": null}, // некорректные
    ].map((e) => NoteModel.fromJson(e)).toList();
  }
}