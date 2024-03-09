class Table {
  int? idTable;
  String? name;
  int? number;

  Table({this.idTable, this.name, this.number});

  Table.fromJson(Map<String, dynamic> json) {
    idTable = json['idTable'];
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTable'] = this.idTable;
    data['name'] = this.name;
    data['number'] = this.number;
    return data;
  }
}