import '../../domain/entities/note.dart';
import '../models/note_model.dart';

class NoteMapper {
  static Note toEntity(NoteModel model) {
    return Note(
      id: model.id ?? 0,
      title: model.title ?? "No title",
      content: model.content ?? "",
    );
  }
}