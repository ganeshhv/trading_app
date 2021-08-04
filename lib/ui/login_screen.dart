import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app/ui/home_page.dart';
import 'package:trading_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _obscureText = true;
  final _formKeyUsername = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final pwdController = TextEditingController();
  final emailController = TextEditingController();
  bool isProcessingLogin = false;
  bool isTablet = false;

  SharedPreferences pref;

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isTablet = AppConstant().isTabletDevice();
    storeData();
  }

  storeData() async{
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loginNormalView(context)
      ),
    );
  }

  Widget loginNormalView(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Stack(
        children: [
          Container(
            height: height/2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightGreen.shade100,
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Text('Login To Trading App',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
                    ),),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Form(
                    key: _formKeyUsername,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!validEmail(value))
                              return 'Please enter valid email';
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  color: Colors.black54
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.green, width: 0.8),
                              // ),
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.green, width: 0.9),
                              // ),
                              hintText: 'Email Id',
                              hintStyle: TextStyle(
                                  color: Colors.black54
                              )
                          ),

                          // style: Style.MainTextStyle.defaultStyle2,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Form(
                    key: _formKeyPassword,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: pwdController,
                          obscureText: _obscureText,
                          // style: Style.MainTextStyle.defaultStyle2,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: Colors.black54
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.green, width: 0.8),
                              // ),
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.green, width: 0.9),
                              // ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.black54
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // GestureDetector(
                //   child: Container(
                //       padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                //       alignment: Alignment.bottomRight,
                //       height: 30,
                //       child: Text("Forgot Password?",
                //           style: Style.MainTextStyle.defaultStyle2)),
                //   onTap: () {
                //     Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => VicasForgotPasswordScreen()));
                //   },
                // ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: isProcessingLogin
                        ? loadingView()
                        : buttonLogin(context),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text('Forgot Email?', style: TextStyle(
                            color: Colors.blue
                        ),),
                        onPressed: null,
                      ),
                      TextButton(
                        child: Text('Forgot Password?', style: TextStyle(
                          color: Colors.blue
                        ),),
                        onPressed: null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  loadingView()
  {
    return Center(
        child: Container(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 1,
          ),
        ));
  }

  Widget buttonLogin(BuildContext context) {
    return (!isTablet) ?   TextButton(
      child: Text('Login'),
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.blueGrey,
        onSurface: Colors.grey,
      ),
      onPressed: () async {
        // setState(() {
        //   isProcessingLogin = true;
        // });
        // emailController.text = 'admin';
        // BlocProvider.of<LoginBloc>(context)
        //     .add(PostLoginApi(email: 'admin', password: 'Password@123'));
        String email = 'admin@gmail.com';
        String password = '1234';
        if (_formKeyUsername.currentState.validate() &&
            _formKeyPassword.currentState.validate()) {
          if(emailController.text == email && pwdController.text == password)
            {
              isProcessingLogin = true;
              AppConstant().isLoggedIn = true;
              pref = await SharedPreferences.getInstance();
              pref.setBool('isLogin', true);
              Get.off(() => HomePage(index: 0,));
            }
          else
            {
              Get.snackbar('Error', 'Email or Password is Incorrect');
            }
        }
      },
    ) : FlatButton(
      // minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      // height: 50,
      color: Colors.blue,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(10),
      splashColor: Colors.blueAccent,
      onPressed: () {
        // setState(() {
        //   isProcessingLogin = true;
        // });
        // emailController.text = 'admin';
        // BlocProvider.of<LoginBloc>(context)
        //     .add(PostLoginApi(email: 'admin', password: 'Password@123'));

        //for adding username and password code
        if (_formKeyUsername.currentState.validate() &&
            _formKeyPassword.currentState.validate()) {
          isProcessingLogin = true;
          AppConstant().isLoggedIn = true;
          // BlocProvider.of<LoginBloc>(context).add(
          //   PostLoginApi(
          //       email: emailController.text, password: pwdController.text),
          // );
        }

        //pass login
        // startTime();
      },
      child: Text(
        "Login",
        // style: Style.MainTextStyle.defaultStyle20,
      ),
    );
  }


  bool validEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}