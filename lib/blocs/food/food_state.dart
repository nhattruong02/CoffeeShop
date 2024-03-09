

import 'package:bloc_api_1/models/food.dart';

abstract class FoodState{

}

class FoodInit extends FoodState{
  List<Food> foods = [];

}

class FoodLoading extends FoodState{

}
class FoodSuccess extends FoodState{
  List<Food> foods = [];
  FoodSuccess(this.foods);
}

class FoodFail extends FoodState{

}

class FoodBillDetailAddMessage extends FoodState{
  String message;
  FoodBillDetailAddMessage(this.message);
}

