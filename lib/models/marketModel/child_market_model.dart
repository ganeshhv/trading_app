class ChildMarketModel {
  String name;
  int id;
  String exchange;
  double price;

  ChildMarketModel({this.name, this.id, this.exchange, this.price});

  ChildMarketModel.fromJson(Map<String, dynamic> json) {
    print('id:${json['id']},${json['id'].runtimeType}');
    print('name:${json['name']},${json['name'].runtimeType}');
    print('exchange:${json['exchange']},${json['exchange'].runtimeType}');
    print('current_price:${json['current_price']},${json['current_price'].runtimeType}');
    name = json['name'];
    id = json['id'];
    exchange = json['exchange'];
    price = json['current_price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['exchange'] = this.exchange;
    data['current_price'] = this.price;
    return data;
  }
}