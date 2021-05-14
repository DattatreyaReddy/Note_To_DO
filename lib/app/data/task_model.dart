class Task {
  int? id;
  String? name;
  int? isDone;

  Task({this.id, this.name, this.isDone});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isDone'] = isDone;
    return data;
  }
}
