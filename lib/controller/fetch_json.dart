import 'dart:convert';

import 'package:flutter/services.dart' as root;
import 'package:trading_app/models/marketModel/market_model.dart';

class FetchJson
{
  Future<MarketModel> getMarketData() async{
    final response = await root.rootBundle.loadString('assets/files/marketwatch.json');
    final json =  await jsonDecode(response);
    print(json.runtimeType);
    final result = MarketModel().fromJson(json);
    print('get data : $result');
    return result;
  }

}