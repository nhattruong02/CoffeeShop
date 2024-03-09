import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listImageFood = ["assets/coffee_1.jpg","assets/coffee_2.jpeg","assets/coffee_3.jpg"];
    List<String> listImageTable = ["assets/table_1.jpg","assets/table_2.jpg"];
    return Container(
      width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 5,top: 20,bottom: 20),
                child: Text("Food",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color: Colors.brown),)),
            CarouselSlider.builder(
                itemCount: listImageFood.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    width: double.infinity,
                    child: Image.asset(listImageFood[index],fit: BoxFit.fill),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 2000)
                )),
            Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 5,top: 20,bottom: 20),
                child: Text("Table",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color: Colors.brown),)),
            CarouselSlider.builder(
                itemCount: listImageTable.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    width: double.infinity,
                    child: Image.asset(listImageTable[index],fit: BoxFit.fill),
                  );
                },
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 2000)
                )),
          ],
        ),
    );
  }
}
