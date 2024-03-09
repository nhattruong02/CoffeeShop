import '../../models/BillDetail.dart';

abstract class BillDetailEvent {

}
class BillDetailShow extends BillDetailEvent{
    int id;
    BillDetailShow(this.id);
}
class BillDetailAdd extends BillDetailEvent{
  BillDetail billDetail;
  BillDetailAdd(this.billDetail);
}
class BillDetailDelete extends BillDetailEvent{
  BillDetail billDetail;
  BillDetailDelete(this.billDetail);
}
class SearchChanged extends BillDetailEvent{
  String txt;
  SearchChanged(this.txt);
}
class SaveBillDetail extends BillDetailEvent{
  int id;
  double total;
  SaveBillDetail(this.id, this.total);
}