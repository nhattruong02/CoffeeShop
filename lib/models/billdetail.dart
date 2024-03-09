class BillDetail{
  int? idBillDetail;
  int? idBill;
  int? idFood;
  int? number;
  String? nameOfFood;
  double? price;
  String? photo;

  BillDetail(
      {this.idBillDetail,
        this.idBill,
        this.idFood,
        this.number,
        this.nameOfFood,
        this.price,
        this.photo});

  BillDetail.fromJson(Map<String, dynamic> json) {
    idBillDetail = json['idBillDetail'];
    idBill = json['idBill'];
    idFood = json['idFood'];
    number = json['number'];
    nameOfFood = json['nameOfFood'];
    price = json['price'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idBillDetail'] = this.idBillDetail;
    data['idBill'] = this.idBill;
    data['idFood'] = this.idFood;
    data['number'] = this.number;
    data['nameOfFood'] = this.nameOfFood;
    data['price'] = this.price;
    data['photo'] = this.photo;
    return data;
  }

  @override
  String toString() {
    return 'BillDetail{idBillDetail: $idBillDetail, idBill: $idBill, idFood: $idFood, number: $number, nameOfFood: $nameOfFood, price: $price, photo: $photo}';
  }
}