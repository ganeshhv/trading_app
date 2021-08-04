import 'package:get/get.dart';
import 'package:trading_app/controller/db_helper.dart';
import 'package:trading_app/controller/fetch_json.dart';
import 'package:trading_app/models/marketModel/market_model.dart';
import 'package:trading_app/models/order_model.dart';
import 'package:trading_app/models/user_model.dart';

class OrderController extends GetxController
{

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getOrdersList();
  }
  @override
  void onClose() {
    super.onClose();
    orderList.close();
  }

  final orderList = <OrderModel>[].obs;

  // add orders
  addOrders(OrderModel model) async{
    return await DbHelper().saveOrders(model);
  }

  //get generated orders
  getOrdersList() async{
    List orderListData = await DbHelper().getOrdersList();
    print('getOrdersList get result:$orderListData');
    if(orderListData == null) orderList.clear();
    else {
      return orderList
          .assignAll(orderListData.map((data) => OrderModel.fromJson(data)).toList());
    }
  }

//update orders
  void updateOrderList(OrderModel orders) async
  {
    await DbHelper().updateOrders(orders);
    getOrdersList();
  }
}