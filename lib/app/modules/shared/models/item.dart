class Item {
  String id;
  String title;
  String description;
  int quantity;
  String start_time;
  String end_time;
  int value;
  String image;
  bool isCreatedByMission;
  List<String> users;
  bool has_video;
  bool has_image;
  bool has_audio;
  bool has_text;

  String user;
  String video;
  String audio;
  String text;

  bool purchased;

  String get name => this.title;

  Item(
      {this.id,
      this.title,
      this.description,
      this.quantity,
      this.start_time,
      this.end_time,
      this.value,
      this.image,
      this.isCreatedByMission,
      this.users,
      this.user,
      this.has_video,
      this.video,
      this.has_audio,
      this.has_image,
      this.audio,
      this.has_text,
      this.purchased});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    quantity = json['quantity'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    value = json['value'];
    image = json['image'];
    title = json['title'];
    isCreatedByMission = json['isCreatedByMission'];
    users = json['users'].map<String>((user) => user.toString()).toList();
    user = json['_user'];
    has_video = json['has_video'];
    has_image = json['has_image'];
    has_audio = json['has_audio'];
    has_text = json['has_text'];
    video = json['video'];
    image = json['image'];
    audio = json['audio'];
    text = json['text'];
    purchased = json['purchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['start_time'] = this.start_time;
    data['end_time'] = this.end_time;
    data['value'] = this.value;
    data['image'] = this.image;
    data['isCreatedByMission'] = this.isCreatedByMission;
    data['users'] = this.users;
    data['_user'] = this.user;
    return data;
  }
}
