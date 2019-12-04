class User {
  String id;
  String email;
  String name;
  String instituition;
  String token;
  int points;

  User({
    this.id,
    this.email,
    this.name,
    this.instituition,
    this.token,
    this.points,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    name = json['name'];
    instituition = json['instituition'];
    points = json['points'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['instituition'] = this.instituition;
    data['token'] = this.token;
    data['points'] = this.points;
    return data;
  }
}
