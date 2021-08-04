import 'package:flutter/material.dart';
import 'package:trading_app/ui/app_bar.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<bool> _onWillPop() {
    print('back pressed');
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Text("NO")),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Text("YES")),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'UserProfile',
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white54,
                  child: Icon(Icons.person_outline_rounded,size: 100,color: Colors.grey,),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Name:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Text('Alex', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('UserID: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Text('ABC123', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Email:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Text('alex@gmail.com', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Address:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Text('Mysore', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}





