class OrderModel
{
  int id;
  String name;
  String price;
  String quantity;
  String order_type;
  String exchange;
  int ts;

  OrderModel({this.id, this.name, this.price, this.quantity, this.order_type, this.exchange, this.ts});

  OrderModel.fromJson(Map json)
  {
    print('id:${json['id']},${json['id'].runtimeType}');
    print('name:${json['name']},${json['name'].runtimeType}');
    print('price:${json['price']},${json['price'].runtimeType}');
    print('quantity:${json['quantity']},${json['quantity'].runtimeType}');
    print('ordertype:${json['order_type']},${json['order_type'].runtimeType}');
    print('exchange:${json['exchange']},${json['exchange'].runtimeType}');
    print('ts:${json['order_ts']},${json['order_ts'].runtimeType}');

    id = json['id'];
    name = json['name'];
    price = json['price'].toString();
    quantity = json['quantity'].toString() ?? '';
    order_type = json['order_type'];
    exchange = json['exchange'];
    ts = json['order_ts'];
  }

  Map toJson() {
    final data = Map<String, Object>();
    data['id'] = id;
    data['name'] = name;
    data['order_ts'] = ts;
    data['price'] = price;
    data['exchange'] = exchange;
    data['order_type'] = order_type;
    data['quantity'] = quantity;

    print('order model to json: $data');
    return data;
  }
}