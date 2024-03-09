import 'package:bloc_api_1/repositories/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/billdetail/bill_detail_bloc.dart';
import '../../../blocs/billdetail/bill_detail_event.dart';
import '../../food_screen/screen/food_screen.dart';
import '../Widget/bill_detail.dart';

class BillDetailScreen extends StatelessWidget {
  String? title;
  int? idbill;
  BillDetailScreen(this.title, this.idbill);
  @override
  Widget build(BuildContext context) {
    ApiService _apiService = ApiService();
    return Scaffold(
      body: BlocProvider(
          create: (context) =>
              BillDetailBloc(_apiService)..add(BillDetailShow(this.idbill!)),
          child: BillDetails(idbill!,title!)),
    );
  }
}
