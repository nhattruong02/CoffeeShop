
import "package:bloc_api_1/blocs/food/food_event.dart";
import "package:bloc_api_1/ui/food_screen/screen/food_screen.dart";
import "package:bloc_api_1/ui/login_screen/screen/login_screen.dart";
import "package:bloc_api_1/ui/table_screen/screen/table_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../blocs/bill/bill_bloc.dart";
import "../../../blocs/bill/bill_event.dart";
import "../../../blocs/table/table_bloc.dart";
import "../../../blocs/table/table_event.dart";
import "../../../repositories/api_services.dart";
import "../../bill_screen/screen/bill_screen.dart";
import "../../home/screen/home_screen.dart";

class MainScreen extends StatefulWidget {
  String role;

  MainScreen(this.role);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String title = "";
  List<String> titles = ["Home", "Table", "Bill"];
  int _selectedIndex = 0;
  Widget _homeScreen = HomeScreen();
  Widget _tableScreen = TableScreen();
  Widget _billScreen = BillScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text(title),
          automaticallyImplyLeading: true,
      ),
      drawer: Drawer(

        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.brown),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Menu",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  )),
            ),
            ListTile(
              leading: Icon(Icons.home, size: 30),
              title: const Text('Home',
                  style: TextStyle(fontSize: 30, color: Colors.grey)),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              leading: Icon(Icons.table_bar, size: 30),
              title: const Text('Table',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  )),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              leading: Icon(Icons.payment, size: 30),
              title: const Text('Bill',
                  style: TextStyle(fontSize: 30, color: Colors.grey)),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              leading: Icon(Icons.logout, size: 30),
              title: const Text('Log out',
                  style: TextStyle(fontSize: 30, color: Colors.grey)),
              selected: _selectedIndex == 3,
              onTap: () {
                ApiService _apiService = ApiService();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen(apiService: _apiService),), (route) => false);
              },
            ),
            Divider(
              height: 0,
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.table_bar), label: "Table"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Bill")
        ],
        selectedItemColor: Colors.white,
        backgroundColor: Colors.brown,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: getBody(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      title = titles[index];
    });
  }

  Widget getBody() {
    ApiService _apiService = ApiService();
    if (_selectedIndex == 0) {
      return _homeScreen;
    } else if (_selectedIndex == 1) {
      return BlocProvider(
        create: (context) => TableBloc(_apiService)..add(TableShow()),
        child: _tableScreen,
      );

    } else {
      return BlocProvider(
        create: (context) => BillBloc(_apiService)..add(BillShow()),
        child: _billScreen,
      );
    }
  }

}
bool _checkRole(String role) {
  if(role == "admin"){
    return true;
  }
  else{
    return false;
  }
}

