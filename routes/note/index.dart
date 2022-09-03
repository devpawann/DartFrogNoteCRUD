import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:notes_crud/src/models/note.dart';
import 'package:notes_crud/src/note/note_data_source.dart';

Future<Response> onRequest(RequestContext requestContext) async {
  switch (requestContext.request.method) {
    case HttpMethod.get:
      return _get(requestContext);

    case HttpMethod.post:
      return _post(requestContext);

    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _post(RequestContext requestContext) async {
  final dataSource = requestContext.read<NoteDataSource>();
  final note = Note.fromJson(await requestContext.request.json());
  return Response.json(
    statusCode: HttpStatus.created,
    body: dataSource.create(note),
  );
}

Response _get(RequestContext requestContext) {
  final dataSource = requestContext.read<NoteDataSource>();
  final notes = dataSource.readAllNote();
  return Response.json(body: notes);
}
