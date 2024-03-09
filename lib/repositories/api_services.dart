import 'package:bloc_api_1/models/Bill.dart';
import 'package:bloc_api_1/ui/bill_detail_screen/Widget/bill_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/BillDetail.dart';
import '../models/food.dart';
import '../models/table.dart';
import '../models/user.dart';
import 'api_urls.dart';

class ApiService {
  Future<List<User>> getUsers() {
    return http.get(ApiUrl().API_USERS_LIST).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      if (statusCode != 200 || jsonBody == null) {
        print(response.reasonPhrase);
      }
      final JsonDecoder _decode = new JsonDecoder();
      final playerListContainer = _decode.convert(jsonBody);
      final List users = playerListContainer['result'];
      return users.map((contactRaw) => new User.fromJson(contactRaw)).toList();
    });
  }

  Future getUser(String username, String password) async {
    final url = "biggreydog78.conveyor.cloud";
    final path = '/getUser';
    final query = {'username': username,
      'password': password};
    final uri = Uri.https(url,path,query);
    print(uri);
    var response = await http.get(uri,headers:  {"Accept":"application/json"});
    if (response.statusCode == 200) {
      try{
      User user = User.fromJson(jsonDecode(response.body));
      return user;
      }catch(_){
        return null;
      }
    }
    else{
      throw Exception("error");
    }
  }


  Future<User> postUser(User user) {
    return http
        .post(ApiUrl().API_USERS_LIST, body: jsonEncode(user),
        headers:  {"Content-Type":"application/json"})
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        print(user.toString());
        print(response.body);
        throw Exception("Fail");
      }
    });
  }

  Future<User> postBill(Bill bill) {
    return http
        .post(ApiUrl().API_BILLS_LIST, body: jsonEncode(bill),
        headers:  {"Content-Type":"application/json"})
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        print(bill.toString());
        print(response.body);
        throw Exception("Fail");
      }
    });
  }

  Future<List<Food>> getFood() {
    return http.get(ApiUrl().API_FOODS_LIST,
      headers: {"Accept":"application/json"}
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      print("body1222 : ${response.body}");
      print(response.statusCode);
      if (statusCode != 200 || jsonBody == null) {
        print(response.reasonPhrase);
      }
      final JsonDecoder _decode = new JsonDecoder();
      final playerListContainer = _decode.convert(jsonBody);
      final List foods = playerListContainer;
      return foods.map((contactRaw) => new Food.fromJson(contactRaw)).toList();
    });
  }
  Future<List<Table>> getTable() {
    return http.get(ApiUrl().API_TABLES_LIST,
        headers: {"Accept":"application/json"}
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      print("body1222 : ${response.body}");
      print(response.statusCode);
      if (statusCode != 200 || jsonBody == null) {
        print(response.reasonPhrase);
      }
      final JsonDecoder _decode = new JsonDecoder();
      final playerListContainer = _decode.convert(jsonBody);
      final List tables = playerListContainer;
      return tables.map((contactRaw) => new Table.fromJson(contactRaw)).toList();
    });
  }
  Future<List<Bill>> getBill() {
    return http.get(ApiUrl().API_BILLS_LIST,
        headers: {"Accept":"application/json"}
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      print("body1222 : ${response.body}");
      print(response.statusCode);
      if (statusCode != 200 || jsonBody == null) {
        print(response.reasonPhrase);
      }
      final JsonDecoder _decode = new JsonDecoder();
      final billListContainer = _decode.convert(jsonBody);
      final List bills = billListContainer;
      return bills.map((contactRaw) => new Bill.fromJson(contactRaw)).toList();
    });
  }

  Future<List<BillDetail>> getBillDetail(int id) async{
    final url = "biggreydog78.conveyor.cloud";
    final path = '/GetBillById';
    final query = {'id': id.toString()};
    final uri = Uri.https(url,path,query);
    var response = await http.get(uri,headers:  {"Accept":"application/json"});
    final JsonDecoder _decode = new JsonDecoder();
    final billdetailListContainer = _decode.convert(response.body);
    final List billdetails = billdetailListContainer;
    return billdetails.map((contactRaw) => new BillDetail.fromJson(contactRaw)).toList();
    }
  Future<Food> postFood(Food food) {
    return http
        .post(ApiUrl().API_FOODS_LIST, body: jsonEncode(food))
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return Food.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Fail");
      }
    });
  }
  Future<BillDetail> postBillDetail(BillDetail billDetail) {
    return http
        .post(ApiUrl().API_BILLDETAILS_LIST ,headers:  {"Content-Type":"application/json"},
        body: jsonEncode(billDetail))
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return BillDetail.fromJson(jsonDecode(response.body));
      } else {
        print(response.body);
        throw Exception("Fail");
      }
    });
  }
  Future<BillDetail> deleteBillDetail(int id) async{
    return http.delete(Uri.parse("${ApiUrl().API_BILLDETAILS_LIST}/$id")).then((http.Response response) {
      if(response.statusCode == 200){
        return BillDetail.fromJson(jsonDecode(response.body));
      }
      else{
        throw Exception("Fail");
      }
    });
  }
  Future<Bill> putBillDetail(int id,double total) async{
    final url = "biggreydog78.conveyor.cloud";
    final path = '/PutBillDetail';
    final query = {'id': id.toString(), "total": total.toString()};
    final uri = Uri.https(url,path,query);
    var response = await http.put(uri,headers:  {"Content-Type":"application/json"},);
    final JsonDecoder _decode = new JsonDecoder();
    final bill = _decode.convert(response.body);

    return bill;
  }
}
