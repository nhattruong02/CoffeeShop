import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/BillDetail.dart';
import '../../repositories/api_services.dart';
import 'bill_detail_event.dart';
import 'bill_detail_state.dart';

class BillDetailBloc extends Bloc<BillDetailEvent, BillDetailState> {
  final ApiService _apiService;
  List<BillDetail> billdetails = [];

  BillDetailBloc(this._apiService) : super(BillDetailInit()) {
    on<BillDetailShow>(_show);
    on<BillDetailDelete>(_delete);
    on<SaveBillDetail>(_save);
  }

  void _show(BillDetailShow event, Emitter<BillDetailState> emit) async {
    emit(BillDetailLoading());
    billdetails = await _apiService.getBillDetail(event.id);
    if (billdetails.isNotEmpty) {
      emit(BillDetailSuccess(billdetails));
    } else {
      emit(BillDetailFail());
    }
  }

  _delete(BillDetailDelete event, Emitter<BillDetailState> emit) async {
    emit(BillDetailLoading());
    var billdetail =
        await _apiService.deleteBillDetail(event.billDetail.idBillDetail!);
    if (billdetail != null) {
      billdetails =
          await _apiService.getBillDetail(event.billDetail.idBill!.toInt());
      emit(BillDetailSuccess(billdetails));
    } else {
      emit(BillDetailFail());
    }
  }

  _save(SaveBillDetail event, Emitter<BillDetailState> emit) async {
    var bill = await _apiService.putBillDetail(event.id, event.total);
    if (bill != null) {
      emit(SaveBillDetailMessage("Success"));
    } else {
      emit(SaveBillDetailMessage("Fail"));
    }
  }
}
