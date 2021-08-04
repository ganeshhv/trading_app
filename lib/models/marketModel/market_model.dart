import 'child_market_model.dart';

class MarketModel {
  List<ChildMarketModel> stocks;

  MarketModel({this.stocks});

  MarketModel fromJson(Map<String, dynamic> json) {
    return MarketModel(
        stocks: (json['stocks'] as List).map((e) => ChildMarketModel.fromJson(e)).toList());
    if (json['stocks'] != null) {
      json['stocks'].forEach((v) {
        stocks.add(new ChildMarketModel.fromJson(v));
      });
      print('stocks:$stocks');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stocks != null) {
      data['stocks'] = this.stocks.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => '$stocks';
}

