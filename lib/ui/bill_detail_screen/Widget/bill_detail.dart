import 'package:bloc_api_1/blocs/billdetail/bill_detail_bloc.dart';
import 'package:bloc_api_1/blocs/billdetail/bill_detail_event.dart';
import 'package:bloc_api_1/models/BillDetail.dart';
import 'package:bloc_api_1/repositories/api_services.dart';
import 'package:bloc_api_1/ui/bill_detail_screen/screen/bill_detail_screen.dart';
import 'package:bloc_api_1/ui/food_screen/screen/food_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/billdetail/bill_detail_state.dart';

class BillDetails extends StatefulWidget {
  int idBill;
  String title;
  BillDetails(this.idBill,this.title);
  @override
  State<BillDetails> createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetails> {
  double totalOfBill = 0;
  @override
  Widget build(BuildContext context) {
    BillDetailBloc _billdetailbloc = BlocProvider.of<BillDetailBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.brown,
          actions: [
            InkWell(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodScreen(widget.idBill),
                      )
                  ).then((value) {
                    _billdetailbloc.add(BillDetailShow(value));
                  },);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.add_circle,size: 30.0),
                ))
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer(
                  listener: (context, state) {
                    if (state is BillDetailLoadingChange) {
                      showDialog(
                          context: context,
                          builder: (context) => const Center(
                                  child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )));
                    }
                    if (state is SaveBillDetailMessage) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(
                            child: Text(state.message,
                          style: TextStyle(color: Colors.black),
                        )),
                        backgroundColor: Colors.white,
                        duration: Duration(seconds: 2),
                      ));
                      Navigator.pop(context, true);
                    }
                  },
                  bloc: _billdetailbloc,
                  builder: (context, state) {
                    if (state is BillDetailLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.blue)),
                      );
                    } else if (state is BillDetailSuccess) {
                      return Column(
                        children: [
                          ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.billDetails.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 80.0,
                                            height: 80.0,
                                            child: Image.network(
                                              state.billDetails[index].photo
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            )),
                                        const SizedBox(
                                          height: 2.0,
                                          width: 30.0,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Name: ${state.billDetails[index].nameOfFood}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 15.0)),
                                              const SizedBox(
                                                height: 7.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 40,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (state
                                                                      .billDetails[
                                                                          index]
                                                                      .number! <=
                                                                  1) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content:
                                                                      Center(
                                                                          child:
                                                                              Text(
                                                                    "Quantily more than 1",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                ));
                                                              } else {
                                                                state
                                                                    .billDetails[
                                                                        index]
                                                                    .number = (state
                                                                        .billDetails[
                                                                            index]
                                                                        .number! -
                                                                    1);
                                                              }
                                                            });
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.brown,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)))),
                                                          child:
                                                              const Text("-"))),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                      state.billDetails[index]
                                                          .number
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      )),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 40,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              state
                                                                  .billDetails[
                                                                      index]
                                                                  .number = (state
                                                                      .billDetails[
                                                                          index]
                                                                      .number! +
                                                                  1);
                                                            });
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.brown,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)))),
                                                          child:
                                                              const Text("+"))),
                                                ],
                                              ),
                                              const SizedBox(height: 7.0),
                                              Text(
                                                  "Price: ${_CalPrice(state.billDetails[index].price, state.billDetails[index].number).toString().substring(0, _CalPrice(state.billDetails[index].price, state.billDetails[index].number).toString().length - 2)} \$ ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 15.0)),
                                            ]),
                                        const SizedBox(
                                          width: 65.0,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SingleChildScrollView(
                                                  child: Center(
                                                    child: AlertDialog(
                                                      title:
                                                          const Text("Delete"),
                                                      content: Column(
                                                        children: [
                                                          Text(
                                                              "Would you like to delete ${state.billDetails[index].nameOfFood} ?")
                                                        ],
                                                      ),
                                                      actions: [
                                                        _Button(
                                                            "Delete",
                                                            context,
                                                            _billdetailbloc,
                                                            state.billDetails[
                                                                index]),
                                                        _Button(
                                                            'Cancel',
                                                            context,
                                                            _billdetailbloc,
                                                            state.billDetails[
                                                                index])
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                              child: const Icon(Icons.delete,
                                                  size: 40,
                                                  color: Colors.brown)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    "Total: ${_totalOfBill(state.billDetails).toString().substring(0, _totalOfBill(state.billDetails).toString().length - 2)} \$",
                                    style: const TextStyle(
                                        color: Colors.brown,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text("Not Data"));
                    }
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () =>
              {_billdetailbloc.add(SaveBillDetail(widget.idBill, totalOfBill))},
          child: const Icon(Icons.save, color: Colors.white, size: 20),
          backgroundColor: Colors.brown,
        ));
  }

  _Button(title, BuildContext context, BillDetailBloc billdetailBloc,
      BillDetail billDetail) {
    return Container(
      width: 125,
      height: 50,
      child: ElevatedButton(
          onPressed: () => {
                if (title == "Cancel")
                  {Navigator.pop(context)}
                else
                  {
                    billdetailBloc.add(BillDetailDelete(billDetail)),
                    Navigator.pop(context)
                  }
              },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }

  _CalPrice(double? price, int? number) {
    double tg = 0;
    tg = price! * number!;
    return tg;
  }

  _totalOfBill(List<BillDetail> billDetails) {
    double total = 0;
    for (int i = 0; i < billDetails.length; i++) {
      total += (billDetails[i].number! * billDetails[i].price!);
    }
    totalOfBill = total;
    return total;
  }
}
