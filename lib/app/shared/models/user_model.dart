class UserModel {
  String id;
  String email;
  String name;
  String institution;
  String token;
  int lux;
  int resources;
  int imp;
  int people;

  UserModel(
      {this.id,
      this.email,
      this.name,
      this.institution,
      this.token,
      this.lux,
      this.resources,
      this.imp,
      this.people});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    name = json['name'];
    institution = json['institution'];
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
    data['institution'] = this.institution;
    data['token'] = this.token;
    data['lux'] = this.lux;
    data['resources'] = this.resources;
    data['imp'] = this.imp;
    data['people'] = this.people;

    return data;
  }
}
