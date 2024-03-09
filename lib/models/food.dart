class Food{
  int? idFood;
  String? name;
  String? type;
  bool? status;
  double? price;
  String? photo;

  Food(
      {this.idFood, this.name, this.type, this.status, this.price, this.photo});

  Food.fromJson(Map<String, dynamic> json) {
    idFood = json['idFood'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    price = json['price'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFood'] = this.idFood;
    data['name'] = this.name;
    data['type'] = this.type;
    data['status'] = this.status;
    data['price'] = this.price;
    data['photo'] = this.photo;
    return data;
  }
}