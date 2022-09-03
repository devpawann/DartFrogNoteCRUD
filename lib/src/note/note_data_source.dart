import 'package:notes_crud/src/models/note.dart';
import 'package:uuid/uuid.dart';

final notes = <Note>[];

class NoteDataSource {
  Note create(Note note) {
    final id = const Uuid().v4();
    final createdNote = note.copyWith(id: id);
    notes.add(createdNote);
    print(notes.toString());
    return createdNote;
  }

  List<Note> readAllNote() {
    return notes;
  }

  Note? readNote(String id) {
    return notes.firstWhere((note) => note.id == id);
  }

  Note updateNote(Note note) {
    final index = notes.indexWhere((noteItem) => noteItem.id == note.id);
    notes[index] = note;
    return note;
  }

  void deleteNote(Note note) {
    notes.remove(note);
  }
}
