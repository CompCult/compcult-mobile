class User {
  String id;
  String email;
  String name;
  String instituition;
  String token;
  int lux;
  int resources;
  int imp;
  int people;

  User(
      {this.id,
      this.email,
      this.name,
      this.instituition,
      this.token,
      this.lux,
      this.resources,
      this.imp,
      this.people});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    name = json['name'];
    instituition = json['instituition'];
    token = json['token'];
    lux = json['lux'];
    resources = json['resources'];
    imp = json['imp'];
    people = json['people'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['instituition'] = this.instituition;
    data['token'] = this.token;
    data['lux'] = this.lux;
    data['resources'] = this.resources;
    data['imp'] = this.imp;
    data['people'] = this.people;

    return data;
  }
}
