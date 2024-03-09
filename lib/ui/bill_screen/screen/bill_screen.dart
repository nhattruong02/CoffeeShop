import 'package:bloc_api_1/repositories/api_services.dart';
import 'package:bloc_api_1/ui/bill_detail_screen/screen/bill_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/bill/Bill_state.dart';
import '../../../blocs/bill/bill_bloc.dart';
import '../../../blocs/bill/bill_event.dart';
import '../../../models/Bill.dart';
class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();

}

class _BillScreenState extends State<BillScreen> {

  TextEditingController name = TextEditingController();
  TextEditingController time= TextEditingController();

  @override
  Widget build(BuildContext context) {
    BillBloc _billbloc = BlocProvider.of<BillBloc>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(7),
                child: TextField(
                    onChanged: (value) => _billbloc.add(SearchChanged(value)),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search")),
              ),
              BlocBuilder(
                  bloc: _billbloc,
                  builder: (context, state) {
                    if (state is BillLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.blue)),
                      );
                    } else if (state is BillSuccess) {
                      return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.bills.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    BillDetailScreen(
                                        state.bills[index].nameTable.toString(),
                                        int.parse(state.bills[index].idBill
                                            .toString())),));
                              _billbloc.add(BillShow());
                            },
                            child: Card(
                              child: Container(
                                 child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 2.0,
                                        ),
                                            Container(
                                              width: double.infinity,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.yellow
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                    "Name Table: ${state.bills[index].nameTable}",style: TextStyle(
                                                    fontWeight: FontWeight.w800,fontSize: 20.0
                                                )),
                                              ),
                                            ),
                                            SizedBox(height: 7.0,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Time: ${state.bills[index].time!.substring(0,10)}",style: TextStyle(
                                                      fontWeight: FontWeight.w800,fontSize: 15.0)),
                                                  SizedBox(height: 7.0),
                                                  Text(
                                                      "Total Of Bill: ${state.bills[index].toalOfBill.toString()
                                                          .substring(0,state.bills[index].toalOfBill.toString().length-2)}",style: TextStyle(
                                                      fontWeight: FontWeight.w800,fontSize: 15.0)),
                                                  SizedBox(height: 7.0),
                                                  Text(
                                                      "Status: ${_showStatus(state.bills[index].status)}",style: TextStyle(
                                                      fontWeight: FontWeight.w800,fontSize: 15.0)),
                                                ],
                                              ),
                                            ),

                                      ],
                                    ),
                                ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text("Not Data"));
                    }
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.small(onPressed: () => {
          showDialog(
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Center(
                child: AlertDialog(
                  title: Text("Add"),
                  content: Column(
                    children: [
                      _textFiel('Name Table', Icons.table_bar, name),
                    ],
                  ),
                  actions: [_Button("Add",context,_billbloc), _Button('Cancel',context,_billbloc)],
                ),
              ),
            );
          },
        )
        },
        child: Icon(Icons.add,color: Colors.white),backgroundColor: Colors.brown),
    );
  }

  _showStatus(bool? status) {
    if (status == true) {
      return "Paid";
    } else {
      return "Unpaid";
    }
  }
  _Button(title,BuildContext context,BillBloc billBloc) {
    return Container(
      width: 125,
      height: 50,
      child: ElevatedButton(
          onPressed: () => {
            if(title == "Cancel"){
              Navigator.pop(context)
            }else{
              // Bill bill = Bill();
              // billBloc.add(BillAdd(bill));
              Navigator.pop(context)
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
          child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 20),
          )
      ),
    );
  }

  _textFiel(String text, IconData icon, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
        ),
      ),
    );
  }
}


