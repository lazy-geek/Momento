
class Note {
  int id;
  String title;
  String content;
  int isPinned;
  String date_created;
  String last_updated;
  Note({this.id,this.title,this.content,this.isPinned,this.date_created,this.last_updated});


  factory Note.fromMap(Map<String, dynamic> map) {
    return new Note(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        isPinned: map['isPinned'],
        date_created: map['date_created'],
        last_updated: map['last_updated']);
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      'title':title,
      'content':content,
      'isPinned':isPinned,
      'date_created':date_created,
      'last_updated':last_updated
    };

    return map;
  }
}