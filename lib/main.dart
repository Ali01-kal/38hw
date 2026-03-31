import 'package:flutter/material.dart';

import 'domain/entities/note.dart';
import 'data/datasources/notes_remote_datasource.dart';
import 'data/datasources/notes_local_datasource.dart';
import 'data/repositories/notes_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = NotesRepositoryImpl(
      NotesRemoteDataSource(),
      NotesLocalDataSource(),
      DataSourceType.cacheFirst,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Notes App")),
        body: FutureBuilder<List<Note>>(
          future: repository.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No notes found"));
            }

            final notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  leading: Text(note.id.toString()),
                  title: Text(note.title),
                  subtitle: Text(note.content),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
