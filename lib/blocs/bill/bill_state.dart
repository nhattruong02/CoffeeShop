

import 'package:bloc_api_1/models/Bill.dart';

abstract class BillState{

}

class BillInit extends BillState{
  List<Bill> bill = [];

}

class BillLoading extends BillState{

}
class BillSuccess extends BillState{
  List<Bill> bills = [];
  BillSuccess(this.bills);
}

class BillFail extends BillState{

}

