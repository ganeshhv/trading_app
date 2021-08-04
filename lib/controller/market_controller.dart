import 'package:get/get.dart';
import 'package:trading_app/controller/db_helper.dart';
import 'package:trading_app/controller/fetch_json.dart';
import 'package:trading_app/models/marketModel/market_model.dart';
import 'package:trading_app/models/order_model.dart';
import 'package:trading_app/models/user_model.dart';

class MarketController extends GetxController
{

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getMarket();
  }
  @override
  void onClose() {
    super.onClose();
    marketList.close();
  }

  final marketList = <MarketModel>[].obs;

  getMarket() async
  {
    final list = await FetchJson().getMarketData();
    marketList.add(list);
    print('marketList:$marketList');
    print('get Market data: ${marketList[0].stocks[0].name}');
  }

}