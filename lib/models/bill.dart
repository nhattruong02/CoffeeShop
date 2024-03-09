class Bill {
  int? idBill;
  int? idStaff;
  int? idTable;
  String? time;
  bool? status;
  double? toalOfBill;
  String? nameTable;

  Bill(
      {this.idBill,
        this.idStaff,
        this.idTable,
        this.time,
        this.status,
        this.toalOfBill,
        this.nameTable});

  Bill.fromJson(Map<String, dynamic> json) {
    idBill = json['idBill'];
    idStaff = json['idStaff'];
    idTable = json['idTable'];
    time = json['time'];
    status = json['status'];
    toalOfBill = json['toalOfBill'];
    nameTable = json['nameTable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idBill'] = this.idBill;
    data['idStaff'] = this.idStaff;
    data['idTable'] = this.idTable;
    data['time'] = this.time;
    data['status'] = this.status;
    data['toalOfBill'] = this.toalOfBill;
    data['nameTable'] = this.nameTable;
    return data;
  }
}