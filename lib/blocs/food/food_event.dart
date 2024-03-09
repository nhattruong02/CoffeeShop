
import '../../models/BillDetail.dart';
import '../../models/food.dart';

abstract class FoodEvent {

}
class FoodShow extends FoodEvent{

}
class FoodAdd extends FoodEvent{
  Food food;
  FoodAdd(this.food);
}
class FoodBillDetailAdd extends FoodEvent{
  BillDetail billDetail;
  FoodBillDetailAdd(this.billDetail);
}

class SearchChanged extends FoodEvent{
  String txt;
  SearchChanged(this.txt);
}