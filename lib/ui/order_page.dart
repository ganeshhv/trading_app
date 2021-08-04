import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trading_app/controller/order_controller.dart';
import 'package:trading_app/ui/app_bar.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  final _orderController = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('binding');
      print(_orderController.getOrdersList());
      return Future.delayed(Duration(seconds: 5), () => CircularProgressIndicator());
    });
  }

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
          title: 'Orders',
        ),
        body: Obx(() {
          if(_orderController.orderList.isEmpty)
            {
              return _nolistMsg();
            }
          else{
            print('isempty: ${_orderController.orderList.isEmpty}');
            print(_orderController.orderList);
            return ListView.builder(
                itemCount: _orderController.orderList.length,
                itemBuilder: (context, index)
                {
                  return Container(
                    height: 65,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    margin: EdgeInsets.only(bottom: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(_orderController.orderList[index].name,
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(_orderController.orderList[index].exchange,
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w400)
                                  ),
                                ),
                              ],
                            ),
                            Text('${DateFormat('HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(_orderController.orderList[index].ts))}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.normal)
                            )

                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Type: ',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(text: '${_orderController.orderList[index].order_type.toUpperCase()}',
                                      style: TextStyle(
                                        color: (_orderController.orderList[index].order_type) == 'buy' ? Colors.green : Colors.red
                                      ))
                                    ]
                                  ),

                                )
                              ),
                              Text('Qty: ${_orderController.orderList[index].quantity}'),
                              Text('Price: ${_orderController.orderList[index].price}')
                            ],
                          ),
                        )

                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white
                    ),
                  );
                }
            );

          }
        }),
      ),
    );
  }

  _nolistMsg()
  {
    return Center(
      child: Text('You have not placed any orders'),
    );
  }
}
