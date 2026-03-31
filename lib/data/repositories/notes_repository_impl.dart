import 'package:flutterhw38/data/datasources/notes_local_datasource.dart';
import 'package:flutterhw38/data/datasources/notes_remote_datasource.dart';
import 'package:flutterhw38/data/mappers/note_mapper.dart';
import 'package:flutterhw38/domain/entities/note.dart';
import 'package:flutterhw38/domain/repositories/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource remote;
  final NotesLocalDataSource local;

  final DataSourceType strategy;

  NotesRepositoryImpl(this.remote, this.local, this.strategy);

  @override
  Future<List<Note>> getNotes() async {
    if (strategy == DataSourceType.cacheFirst) {
      // 1. кеш
      final cached = await local.getCachedNotes();
      if (cached.isNotEmpty) {
        return cached.map(NoteMapper.toEntity).toList();
      }

      // 2. сервер
      final remoteData = await remote.fetchNotes();
      await local.cacheNotes(remoteData);
      return remoteData.map(NoteMapper.toEntity).toList();

    } else {
      // remoteFirst
      final remoteData = await remote.fetchNotes();
      await local.cacheNotes(remoteData);
      return remoteData.map(NoteMapper.toEntity).toList();
    }
  }
}

enum DataSourceType { remoteFirst, cacheFirst }