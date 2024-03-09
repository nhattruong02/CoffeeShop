
import 'package:bloc_api_1/models/BillDetail.dart';

import '../../models/BillDetail.dart';
abstract class BillDetailState{

}

class BillDetailInit extends BillDetailState{
  List<BillDetail> billDetail = [];

}

class BillDetailLoading extends BillDetailState{

}

class BillDetailLoadingChange extends BillDetailState{

}
class BillDetailSuccess extends BillDetailState{
  List<BillDetail> billDetails = [];
  BillDetailSuccess(this.billDetails);
}

class BillDetailFail extends BillDetailState{

}
class SaveBillDetailMessage extends BillDetailState{
  String message;
  SaveBillDetailMessage(this.message);
}


