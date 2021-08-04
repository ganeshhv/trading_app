class UserModel
{
  int id;
  String name;
  String email;
  String address;
  String userId;
  String phoneNumber;
  int ts;

  UserModel({this.id, this.name, this.email, this.address, this.userId, this.phoneNumber, this.ts});

  UserModel.fromJson(Map json)
  {
    print('id:${json['id']},${json['id'].runtimeType}');
    print('name:${json['name']},${json['name'].runtimeType}');
    print('email:${json['email']},${json['email'].runtimeType}');
    print('address:${json['address']},${json['address'].runtimeType}');
    print('userid:${json['userId']},${json['userId'].runtimeType}');
    print('phone:${json['phone']},${json['phone'].runtimeType}');
    print('ts:${json['ts']},${json['ts'].runtimeType}');

    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'] ?? '';
    userId = json['userId'];
    phoneNumber = json['phone'];
    ts = json['ts'];
  }

  Map toJson() {
    final data = Map<String, Object>();
    data['id'] = id;
    data['name'] = name;
    data['ts'] = ts;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phoneNumber;

    print('user model to json: $data');
    return data;
  }
}