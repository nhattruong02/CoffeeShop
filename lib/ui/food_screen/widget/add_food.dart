
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/food/food_bloc.dart';
import '../../../blocs/food/food_event.dart';
import '../../../blocs/food/food_state.dart';
import '../../../models/BillDetail.dart';
import '../../../models/food.dart';
class AddFood extends StatefulWidget {
  final int idBill;
  const AddFood(this.idBill, {super.key});
  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  @override
  Widget build(BuildContext context) {
    FoodBloc _foodbloc = BlocProvider.of<FoodBloc>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(7),
                child: TextField(
                    onChanged: (value) => _foodbloc.add(SearchChanged(value)),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search")),
              ),
              BlocConsumer(
                  listener: (context, state) {
                    if(state is FoodBillDetailAddMessage){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Center(child: Text(state.message,style: const TextStyle(color: Colors.black),)),
                            backgroundColor: Colors.white,duration: const Duration(seconds: 1),));
                    }
                  },
                  bloc: _foodbloc,
                  builder: (context, state) {
                    if(state is FoodLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.blue)),
                      );

                    } else if (state is FoodSuccess) {
                      return GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemCount: state.foods.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: InkWell(
                                onTap: () {
                                  if(state.foods[index].status!){
                                    _showDialog(context, state.foods[index],_foodbloc);
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Center(child: Text("${state.foods[index].name} solded out",style: TextStyle(color: Colors.black),)),
                                          backgroundColor: Colors.white,duration: Duration(seconds: 1),));
                                  }
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                        padding:
                                        const EdgeInsets.only(top: 5.0),
                                        child: SizedBox(
                                            width: 120.0,
                                            height: 100.0,
                                            child: Image.network(width: 100.0,fit: BoxFit.fill,
                                                height: 100.0,state.foods[index].photo.toString()))),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Name: ${state.foods[index].name}",style: const TextStyle(
                                            fontWeight: FontWeight.w800
                                        )),
                                        Text(
                                            "Price: ${state.foods[index].price.toString().substring(
                                              0,state.foods[index].price.toString().length-2)} \$",style: const TextStyle(
                                            fontWeight: FontWeight.w800)),
                                        Text(
                                            "Type: ${state.foods[index].type}",style: const TextStyle(
                                            fontWeight: FontWeight.w800)),
                                        Text(
                                            "Status: ${_showStatus(state.foods[index].status)}",style: const TextStyle(
                                            fontWeight: FontWeight.w800 )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                        },
                      );
                    } else {
                      return const Center(child: Text("Not Data"));
                    }
                  }),
            ],
          ),
        ),
    );
  }

  _showStatus(bool? status) {
    if (status == true) {
      return "Available";
    } else {
      return "Sold out";
    }
  }
  _showDialog(BuildContext context, Food food,FoodBloc _foodbloc) {
    BillDetail billDetail;
    int _count = 1;
    showDialog(context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 320,
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                        width: 120.0,
                        height: 100.0,
                        child: Image.network(food.photo.toString()))
                ),
                const SizedBox(
                  height: 2.0,
                ),
                const SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${food.name}",style: const TextStyle(
                        fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10,),
                    Text("Price: ${food.price}",style: const TextStyle(
                        fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        child: ElevatedButton(onPressed: (){
                          setState((){
                            if(_count <= 1){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text("Quantily more than 1",style: TextStyle(color: Colors.black),)),
                                    backgroundColor: Colors.white,duration: Duration(seconds: 1),));
                            }else{
                              _count--;
                            }
                          });
                        },style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                        ), child: const Text("-"))),
                    Text('$_count',style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    )),
                    Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        child: ElevatedButton(onPressed: (){
                          setState(() {
                            _count++;
                          });
                        },style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                        ),
                            child: const Text("+"))),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(onPressed: () => {
                        billDetail = BillDetail(idFood:food.idFood ,photo:food.photo ,price: food.price
                            ,idBill: widget.idBill ,number: _count,nameOfFood: food.name ),
                        _foodbloc.add(FoodBillDetailAdd(billDetail)),
                        Navigator.pop(context)
                      },style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            )
                        ),
                        child: const Text("Add"),  ),
                    ),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(onPressed: () => Navigator.pop(context),style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            )
                        ),
                        child: const Text("Cancel"), ),
                    )
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
