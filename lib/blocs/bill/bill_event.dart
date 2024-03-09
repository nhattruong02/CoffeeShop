
import '../../models/Bill.dart';

abstract class BillEvent {

}
class BillShow extends BillEvent{

}
class BillAdd extends BillEvent{
  Bill bill;
  BillAdd(this.bill);
}
class SearchChanged extends BillEvent{
  String txt;
  SearchChanged(this.txt);
}