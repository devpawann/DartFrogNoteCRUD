import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:notes_crud/src/models/note.dart';
import 'package:notes_crud/src/note/note_data_source.dart';

Future<Response> onRequest(RequestContext requestContext, String id) async {
  final dataSource = requestContext.read<NoteDataSource>();
  final notes = dataSource.readNote(id);
  if (notes == null) {
    return Response(statusCode: HttpStatus.notFound, body: 'Not found');
  }

  switch (requestContext.request.method) {
    case HttpMethod.get:
      return _get(requestContext, notes);

    case HttpMethod.post:
      return _update(requestContext, notes);

    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext requestContext, Note note) async {
  return Response.json(body: note.toJson());
}

Future<Response> _update(RequestContext requestContext, Note note) async {
  final dataSource = requestContext.read<NoteDataSource>();
  final incomingNote = Note.fromJson(await requestContext.request.json());
  final newNote = note.copyWith(content: incomingNote.content);
  dataSource.updateNote(newNote);
  return Response.json(body: newNote.toJson());
}
