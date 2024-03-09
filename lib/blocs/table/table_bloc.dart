import 'dart:async';

import 'package:bloc_api_1/blocs/table/table_event.dart';
import 'package:bloc_api_1/blocs/table/table_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/table.dart';
import '../../repositories/api_services.dart';

class TableBloc extends Bloc<TableEvent,TableState>{
  final ApiService _apiService;
  List<Table> tables = [];
  TableBloc(this._apiService) : super (TableInit()) {
    on<TableShow>(_show);
    on<SearchChanged>(_search);
  }

  void _show(TableShow event, Emitter<TableState> emit) async{
    emit(TableLoading());
    tables = await _apiService.getTable();
    if (tables.isNotEmpty) {
      emit(TableSuccess(tables));
    } else {
      emit(TableFail());
    }
  }
  void _search(SearchChanged event, Emitter<TableState> emit) {
    List<Table> tableSearch = [];
    for(int i=0;i <tables.length ; i++){
      if(tables[i].name.toString().contains(event.txt) ||
          tables[i].number.toString().contains(event.txt)){
        tableSearch.add(tables[i]);
      }
    }
    emit(TableSuccess(tableSearch));
  }
}