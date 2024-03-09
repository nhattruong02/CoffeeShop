import 'package:bloc_api_1/blocs/table/table_event.dart';
import 'package:bloc_api_1/ui/login_screen/widget/login_form.dart';
import 'package:bloc_api_1/ui/main_screen/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/table/table_bloc.dart';
import '../../../blocs/table/table_state.dart';
class TableScreen extends StatefulWidget {

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {

  @override
  Widget build(BuildContext context) {
    TableBloc _tablebloc = BlocProvider.of<TableBloc>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(7),
                child: TextField(
                  onChanged: (value) => _tablebloc.add(SearchChanged(value)),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search")),
              ),
              BlocBuilder(
                  bloc: _tablebloc,
                  builder: (context, state) {
                    if (state is TableLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.blue)),
                      );
                    } else if (state is TableSuccess) {
                      return GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemCount: state.tables.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: InkWell(
                              onTap: () =>{},
                                  // _showDialog(context, state.tables[index]),
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                        padding:
                                        const EdgeInsets.only(top: 5.0),
                                        child: SizedBox(
                                            width: 120.0,
                                            height: 100.0,
                                            child: Image.asset(_imagetable(state.tables[index].number),fit: BoxFit.fill),)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Name: ${state.tables[index].name}",style: TextStyle(
                                            fontWeight: FontWeight.w800,fontSize: 17.0
                                        )),
                                        SizedBox(height: 10.0,),
                                        Text(
                                            "Number: ${state.tables[index].number}",style: TextStyle(
                                            fontWeight: FontWeight.w800,fontSize: 17.0)),
                                      ],
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
    );
  }

  String _imagetable(int? number) {
      int number1 = int.parse(number.toString());
      if(number1 <= 4){
        return "assets/table_2.jpg";
      }
      else{
        return "assets/table_1.jpg";
      }
  }
}
