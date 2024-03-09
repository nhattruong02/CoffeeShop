
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/Bill.dart';
import '../../repositories/api_services.dart';
import 'Bill_state.dart';
import 'bill_event.dart';

class BillBloc extends Bloc<BillEvent,BillState>{
  final ApiService _apiService;
  List<Bill> Bills = [];
  BillBloc(this._apiService) : super (BillInit()) {
    on<BillShow>(_show);
    on<BillAdd>(_add);
    on<SearchChanged>(_search);
  }

  void _show(BillShow event, Emitter<BillState> emit) async{
    emit(BillLoading());
    Bills = await _apiService.getBill();
    if (Bills.isNotEmpty) {
      emit(BillSuccess(Bills));
    } else {
      emit(BillFail());
    }
  }


  FutureOr<void> _add(BillAdd event, Emitter<BillState> emit) async {
    emit(BillLoading());
    var bill = await _apiService.postBill(event.bill);
    if (bill  != null) {

    }
  }

  void _search(SearchChanged event, Emitter<BillState> emit) {
    List<Bill> billSearch =[];
    for(int i=0;i <Bills.length ; i++){
      if(Bills[i].nameTable.toString().contains(event.txt) ){
        billSearch.add(Bills[i]);
      }
    }
    emit(BillSuccess(billSearch));
  }
}