class MemoryGame {
  String id;
  String title;
  String description;
  int points;
  bool isPublic;
  String secretCode;
  List<String> users;
  List images;
  String user;
  String createdAt;
  String updatedAt;

  MemoryGame(
      {this.id,
      this.title,
      this.description,
      this.points,
      this.isPublic,
      this.secretCode,
      this.users,
      this.images,
      this.user,
      this.createdAt,
      this.updatedAt});

  MemoryGame.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    points = json['points'];
    isPublic = json['is_public'];
    secretCode = json['secret_code'];
    images = json['images'];
    user = json['_user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['points'] = this.points;
    data['is_public'] = this.isPublic;
    data['secret_code'] = this.secretCode;
    data['users'] = this.users;
    data['images'] = this.images;
    data['_user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
