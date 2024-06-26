import 'package:objectbox/objectbox.dart';

@Entity()
class Note {
  Note(
      {this.id = 0,
      this.uuid,
      this.previewContent,
      this.title,
      this.content,
      this.notebook,
      this.isBookmark = false,
      this.dateCreated,
      this.includePic = false});
  @Id()
  int id;
  String? uuid;
  String? previewContent;
  String? title;
  String? content;
  bool? isBookmark;
  bool? includePic;
  DateTime? dateCreated;

  /// these two
  List<String>? notebook;
  // var lastMo`dified;
}
