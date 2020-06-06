class GroupModel {
  int id;
  String description;
  String name;
  int v;
  String createdAt;

  GroupModel({this.id, this.description, this.name, this.v, this.createdAt});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    name = json['name'];
    v = json['__v'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['description'] = this.description;
    data['name'] = this.name;
    data['__v'] = this.v;
    data['created_at'] = this.createdAt;
    return data;
  }
}
