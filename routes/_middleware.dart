import 'package:dart_frog/dart_frog.dart';
import 'package:notes_crud/src/note/note_data_source.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<NoteDataSource>((context) => NoteDataSource()));
}
