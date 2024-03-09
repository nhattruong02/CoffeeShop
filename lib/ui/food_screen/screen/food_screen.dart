import 'package:bloc_api_1/blocs/food/food_bloc.dart';
import 'package:bloc_api_1/blocs/food/food_event.dart';
import 'package:bloc_api_1/blocs/food/food_state.dart';
import 'package:bloc_api_1/models/BillDetail.dart';
import 'package:bloc_api_1/repositories/api_services.dart';
import 'package:bloc_api_1/ui/food_screen/widget/add_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/billdetail/bill_detail_bloc.dart';
import '../../../models/food.dart';

class FoodScreen extends StatelessWidget {
  int idBill;

  FoodScreen(this.idBill);

  ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed:  () => Navigator.pop(context,idBill),
        ),
          backgroundColor: Colors.brown,
          title: Text("Food"),
          automaticallyImplyLeading: true,
          centerTitle: true),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FoodBloc(_apiService)..add(FoodShow(),)),
          BlocProvider(
              create: (context) => BillDetailBloc(_apiService)),
        ],
        child: AddFood(idBill),
      ),
    );
  }
}

