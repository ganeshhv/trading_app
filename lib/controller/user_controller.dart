import 'package:get/get.dart';
import 'package:trading_app/controller/db_helper.dart';
import 'package:trading_app/controller/fetch_json.dart';
import 'package:trading_app/models/marketModel/market_model.dart';
import 'package:trading_app/models/order_model.dart';
import 'package:trading_app/models/user_model.dart';

class UserController extends GetxController
{

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUserData();
  }
  @override
  void onClose() {
    super.onClose();
    userList.close();
  }

  final userList = <UserModel>[].obs;

  // add User to table
  addUser(UserModel model) async
  {
    return await DbHelper().saveUser(model);
  }

  // get user data
  getUserData() async{
    List qrListData = await DbHelper().getUser();
    print('getcontroller getUserData result:$qrListData');
    if(qrListData == null) userList.clear();
    else userList.assignAll(qrListData.map((data) => UserModel.fromJson(data)).toList());
  }

  //update list
  void updateUserList(UserModel user) async
  {
    await DbHelper().updateUser(user);
    getUserData();
  }
}