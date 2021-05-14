class Note {
  int? id;
  String? title;
  String? description;
  String? timestamp;

  Note({this.id, this.title, this.description, this.timestamp});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['timestamp'] = timestamp;
    return data;
  }
}
