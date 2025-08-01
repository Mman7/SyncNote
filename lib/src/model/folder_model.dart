import 'dart:convert';
import 'package:objectbox/objectbox.dart';
import 'package:melonote/src/model/note_model.dart';
import 'package:melonote/src/modules/local_database.dart';
import 'package:melonote/objectbox.g.dart';

@Entity()
class FolderModel {
  FolderModel(
      {this.id = 0,
      required this.title,
      required this.noteInclude,
      required this.uuid});
  @Id()
  int id;
  @Unique()
  String uuid; // Unique identifier for the folder

  String title;
  // List covert into string
  String? noteInclude;
  get getNoteIncluded => _getConvertNoteIncluded();

  List<int> _getConvertNoteIncluded() {
    try {
      return List<int>.from(jsonDecode(noteInclude ?? '[]'));
    } catch (err) {
      return [];
    }
  }

  addNote({required int noteId}) {
    List<int> newList = List.from(getNoteIncluded);
    if (newList.contains(noteId)) {
      return; // Folder already included
    }
    newList.add(noteId);
    noteInclude = jsonEncode(newList);
    Database().updateFolder(folder: this);
  }

  void removeNote({required int noteId}) {
    List<int> newList = getNoteIncluded;
    newList.remove(noteId);
    noteInclude = jsonEncode(newList);
    Database().updateFolder(folder: this);
  }

  /// Filter out [null]
  void refreshNoteIncluded() {
    Database database = Database();
    List result = database.getManyNote(list: getNoteIncluded);
    List newList = [];
    for (Note? e in result) {
      if (e != null) newList.add(e.id);
    }
    noteInclude = jsonEncode(newList);
    Database().updateFolder(folder: this);
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'uuid': uuid,
      'noteInclude': noteInclude,
    };
  }
}
