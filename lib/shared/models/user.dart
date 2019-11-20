class User {
  int id;
  String email;
  String name;
  String instituition;

  User({this.id, this.email, this.name, this.instituition});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    name = json['name'];
    instituition = json['instituition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['instituition'] = this.instituition;
    return data;
  }
}
