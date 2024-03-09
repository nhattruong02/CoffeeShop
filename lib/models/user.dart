class User {
  int? id;
  String? fullname;
  String? username;
  String? password;
  String? phone;
  String? role;

  User([this.fullname, this.username, this.password, this.phone,
      this.id, this.role]);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, fullname: $fullname, username: $username, password: $password, phone: $phone, role: $role}';
  }
}
