import 'package:covid/Firebase/Constant.dart';
import 'package:covid/Firebase/auth.dart';
import 'package:covid/theme/localdb.dart';
import 'package:covid/theme/routes.dart';
import 'package:covid/views/Pages/FoodScreen.dart';
import 'package:covid/views/Pages/MedicineScreen.dart';
import 'package:covid/views/Pages/OtherScreen.dart';
import 'package:covid/views/Pages/OxygenScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    signOut() async {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      // move the user to login screen
      FirebaseAuth.instance.idTokenChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        } else {
          print('User is signed in!');
        }
      });
    }

    void handleClick(String value) {
      switch (value) {
        case 'Logout':
          signOut();
          ;
          break;
        case 'Settings':
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: NetworkImage(constant.userimageurl),
          ),
          onPressed: () {},
        ),
        title: Text('CovidCare'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: HomeScreenFul(),
    );
  }
}

class HomeScreenFul extends StatefulWidget {
  const HomeScreenFul({Key? key}) : super(key: key);

  @override
  _HomeScreenFulState createState() => _HomeScreenFulState();
}

class _HomeScreenFulState extends State<HomeScreenFul> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    FoodScreen(),
    MedicineScreen(),
    OxygenScreen(),
    OtherScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.food_bank,
                  ),
                  label: 'Food',
                  backgroundColor: Colors.teal,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.medical_services,
                  ),
                  label: 'Medicine',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.wheelchair_pickup,
                    ),
                    label: 'Oxygen',
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.other_houses,
                  ),
                  label: 'Other',
                  backgroundColor: Colors.yellow,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          )
        ],
      ),
    );
  }
}
