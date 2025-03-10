// ignore: file_names
import 'package:syncnote/myobjectbox.dart';
import 'package:syncnote/objectbox.g.dart';
import 'package:syncnote/src/model/note_model.dart';
import 'package:syncnote/src/model/notebooks_model.dart';

class Database {
  final noteBox = objectbox.store.box<Note>();
  final noteBookBox = objectbox.store.box<Notebook>();

  getNote({required int id}) {
    final note = noteBox.get(id);
    return note;
  }

  getAllNote() {
    final notes = noteBox.getAll();
    return notes;
  }

  getAllNoteBook() {
    final noteBookList = objectbox.store.box<Notebook>().getAll();
    return noteBookList;
  }

  getSpecificNoteBook({required int id}) {
    // prevent first launch value equals to null
    if (noteBookBox.getAll().isEmpty) return;
    String noteBooktitle = objectbox.store.box<Notebook>().get(id)!.title;
    final query =
        noteBox.query(Note_.notebook.containsElement(noteBooktitle)).build();
    final noteBookData = query.find();

    return noteBookData;
  }

  toggleBookMarked({required int noteId}) {
    final Note note = getNote(id: noteId);
    note.isBookmark = !note.isBookmark!;
    saveNote(note: note);
  }

  saveNote({required Note note}) {
    noteBox.put(note);
  }

  removeNote({required id}) {
    noteBox.remove(id);
  }

  removeNoteBook({required id}) {
    noteBookBox.remove(id);
  }
}
