import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app/ui/login_screen.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {

  final String title;

  @override
  final Size preferredSize;

  CustomAppbar({this.title}) : preferredSize = Size.fromHeight(50.0);
  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        myPopMenu()
      ],
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                height: 30.0,
                width: 30.0,
                child: Icon(Icons.person_outline_rounded)
            ),
          ),
        ),
        onSelected: (value) {
          _onLogoutPressed();
        },
        itemBuilder: (context) => [
          // PopupMenuItem(
          //     value: 1,
          //     child: Text('Profile')
          // ),
          PopupMenuItem(
              value: 1,
              child: Container(
                  height: 30,
                  width: 50,
                  child: Text('Logout'))
          ),
        ]);
  }

  _onLogoutPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to Logout'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              clearSession();
              Get.offAll(() => LoginScreen());

            },
          ),
        ],
      ),
    ) ??
        false;
  }

  clearSession() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
