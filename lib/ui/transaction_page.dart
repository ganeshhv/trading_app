import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trading_app/controller/market_controller.dart';
import 'package:trading_app/controller/order_controller.dart';
import 'package:trading_app/models/order_model.dart';
import 'package:trading_app/ui/home_page.dart';
import 'package:trading_app/ui/order_page.dart';

class TransactionPage extends StatefulWidget {
  final String type;
  final int index;

  TransactionPage({this.type, this.index});
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _marketController = Get.put(MarketController());
  final _orderController = Get.put(OrderController());


  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _marketController.dispose();
    _orderController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.type == 'buy') ? Text('New buy order') : Text(
            'New sell order'),
      ),
      body: Container(
        color: Colors.white12,
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(_marketController.marketList[0]
                              .stocks[widget.index].name.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(_marketController.marketList[0]
                              .stocks[widget.index].exchange.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                  Text('₹${_marketController.marketList[0].stocks[widget.index]
                      .price.toString()}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Quantity', style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      controller: _quantityController,
                      style: TextStyle(
                          fontSize: 20
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration.collapsed(
                          hintTextDirection: TextDirection.rtl,
                          hintText: '1'
                      ),
                    ),
                  )

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Divider(height: 1, color: Colors.black87,),
            ),
            //order type
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Order type', style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: (widget.type == 'buy')
                        ? Text('Buy', style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.green))
                        : Text('Sell', style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.red)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Divider(height: 1, color: Colors.black87,),
            ),
            //price
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Price', style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      controller: _priceController,
                      style: TextStyle(
                          fontSize: 20
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration.collapsed(
                          hintTextDirection: TextDirection.rtl,
                          hintText: '0'
                      ),
                    ),
                  )

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Divider(height: 1, color: Colors.black87,),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: (widget.type == 'buy') ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if(_quantityController.text.isEmpty)
                        {
                          showSnackbar('Enter the Quantity','Error', Colors.red);
                        }
                      else if(_priceController.text.isEmpty)
                      {
                        showSnackbar('Enter the Price','Error', Colors.red);
                      }
                      else placeOrder();
                    },
                    child: Text('Confirm Order', style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }



  placeOrder() async
  {
    String stockName = _marketController.marketList[0].stocks[widget.index]
        .name;
    String exchange = _marketController.marketList[0].stocks[widget.index]
        .exchange;
    String price = _priceController.text;
    String quantity = _quantityController.text;
    String orderType = widget.type;
    final ts = DateTime
        .now()
        .millisecondsSinceEpoch;


    // add data to db
    OrderModel model = OrderModel(
        name: stockName,
        price: price.toString(),
        quantity: quantity.toString(),
        order_type: orderType,
        exchange: exchange,
        ts: ts
    );
    print(model.name);

    await _orderController.addOrders(model);
    Map orderList = await _orderController.getOrdersList();
    Get.offAll(() => HomePage(index: 1,));
  }
  showSnackbar(String message, String title, Color color) {
    return Get.snackbar(title, message,snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color, colorText: Colors.white);
  }

  @override
  void initState() {
    _priceController.text = _marketController.marketList[0].stocks[widget.index].price.toString();
  }
}