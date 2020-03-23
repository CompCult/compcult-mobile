class Item {
  String id;
  String title;
  String description;
  int quantity;
  String start_time;
  String end_time;
  int value; 
  String image;


  String get name => this.title;

  Item(
      {this.id,
      this.title,
      this.description,
      this.quantity,
      this.start_time,
      this.end_time,
      this.value,
      this.image
      });

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
    return data;
  }
}
