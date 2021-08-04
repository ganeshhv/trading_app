import 'package:flutter/material.dart';
import 'package:trading_app/ui/market_watch.dart';
import 'package:trading_app/ui/order_page.dart';
import 'package:trading_app/ui/profile_page.dart';

class HomePage extends StatefulWidget {
  final int index;

  HomePage({this.index});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _currentIndex = 0;
  List<Widget> _children = [
    MarketWatchPage(),
    OrderPage(),
    ProfilePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.index ?? 0;
    _currentIndex = widget.index;
  }
  _onTap() { // this has changed
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => _children[_currentIndex])); // this has changed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              print('changed to index:$index');
              _currentIndex = index;
            });
          },
          key: _bottomNavigationKey,
          selectedItemColor: Colors.blue,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Market'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                label: 'Orders'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Profile'
            ),
          ]
      ),
    );
  }
}