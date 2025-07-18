import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

@Entity()
class Note {
  Note({
    this.id = 0,
    required this.uuid,
    required this.title,
    required this.content,
    required this.previewContent,
    this.isBookmark = false,
    this.dateCreated,
    this.lastestModified,
  });
  @Id()
  int id;
  String uuid;
  String previewContent;
  String content;
  String title;
  bool? isBookmark;
  DateTime? dateCreated;
  DateTime? lastestModified;

  factory Note.newNote() {
    return Note(
      uuid: Uuid().v4(),
      title: '',
      content: '',
      previewContent: '',
    );
  }
}
