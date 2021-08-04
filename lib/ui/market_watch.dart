import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:trading_app/controller/market_controller.dart';
import 'package:trading_app/ui/app_bar.dart';
import 'package:trading_app/ui/transaction_page.dart';

class MarketWatchPage extends StatefulWidget {
  @override
  _MarketWatchPageState createState() => _MarketWatchPageState();
}

class _MarketWatchPageState extends State<MarketWatchPage> {

  final _controller = Get.put(MarketController());

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
          title: 'Market',
        ),
        body: Obx((){
          if(_controller.marketList.isEmpty)
            {
              return _nolistMsg();
            }
          else
            {
              print('isempty: ${_controller.marketList.isEmpty}');
              print(_controller.marketList);
              return ListView.builder(
                  itemCount: _controller.marketList[0].stocks.length,
                  itemBuilder: (context, index)
                  {
                    return InkWell(
                      child: Container(
                        child: Card(
                          child: ListTile(
                            title: Text(_controller.marketList[0].stocks[index].name),
                            subtitle: Text(_controller.marketList[0].stocks[index].exchange),
                            trailing: Text(_controller.marketList[0].stocks[index].price.toString()),
                          ),
                        ),
                      ),
                      onTap: (){
                        openAlertBox(index);
                      },
                    );
                  }
              );
            }
        }),
      ),
    );

  }

  openAlertBox(int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "BUY/SELL",
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_controller.marketList[0].stocks[index].name,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_controller.marketList[0].stocks[index].exchange,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200)),
                            )

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_controller.marketList[0].stocks[index].price.toString(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                        )
                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                              ),
                            ),
                            child: Text(
                              "BUY",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: (){
                            Get.back();
                            Get.to(() => TransactionPage(type: 'buy',index: index,));

                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: Text(
                              "SELL",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: (){
                            Get.back();
                            Get.to(() => TransactionPage(type: 'sell',index: index,));

                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  _nolistMsg()
  {
    return Center(
      child: Text('No QR LIST FOUND'),
    );
  }
}
