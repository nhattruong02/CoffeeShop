import 'dart:async';

import 'package:bloc_api_1/models/BillDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/food.dart';
import '../../repositories/api_services.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent,FoodState>{
  final ApiService _apiService;
  List<Food> foods = [];
  FoodBloc(this._apiService) : super (FoodInit()) {
    on<FoodShow>(_show);
    on<FoodAdd>(_add);
    on<FoodBillDetailAdd>(_addbilldetail);
    on<SearchChanged>(_search);
  }

  Future<List<Food>> getFood() async{
    foods = await _apiService.getFood();
    return foods;
  }
  void _show(FoodShow event, Emitter<FoodState> emit) async{
    emit(FoodLoading());
    foods = await getFood();
    print(foods);
    if (foods.isNotEmpty) {
      emit(FoodSuccess(foods));
    } else {
      emit(FoodFail());
    }
  }


  FutureOr<void> _add(FoodAdd event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
    var food = await _apiService.postFood(event.food);
    if (food != null) {
      foods = await getFood();
      emit(FoodSuccess(foods));
    } else {
      emit(FoodFail());
    }
  }

  void _search(SearchChanged event, Emitter<FoodState> emit) {
    List<Food> foodSearch =[];
    for(int i=0;i <foods.length ; i++){
      if(foods[i].name.toString().toLowerCase().trim().contains(event.txt) ||
          foods[i].type.toString().toLowerCase().trim().contains(event.txt.toLowerCase()) ||
          foods[i].status.toString().toLowerCase().trim().contains(event.txt.toLowerCase())){
        foodSearch.add(foods[i]);
      }
    }
    emit(FoodSuccess(foodSearch));
  }

  FutureOr<void> _addbilldetail(FoodBillDetailAdd event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
    var billdetail = await _apiService.postBillDetail(event.billDetail as BillDetail);
    if ( billdetail != null) {
      emit(FoodBillDetailAddMessage("Added ${billdetail.nameOfFood}"));
      emit(FoodSuccess(foods));
    } else {
      emit(FoodBillDetailAddMessage("Fail"));
    }
  }
}