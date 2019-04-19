import 'dart:convert';

import 'package:PMES/net/net_constants.dart';
import 'package:PMES/net/net_utils.dart';
import 'package:PMES/pages/page_home.dart';
import 'package:PMES/utils/dialog_utils.dart';
import 'package:PMES/utils/log.dart';
import 'package:PMES/widget/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(new MaterialApp(
    title: 'LoginPage',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailEditingController;
  TextEditingController _passwordEditingController;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController()
      ..value = TextEditingValue(text:"admin@yuantutech.com");

    _passwordEditingController = TextEditingController()
      ..value = TextEditingValue(text:"admin");
  }

  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('LoginPage'),
      ),
      body: Container(
        child: _buildMainLayout(),
      ),
    );
  }

  _buildMainLayout(){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28,0,28,0),
          child: TextField(
            controller: _emailEditingController,
            decoration: InputDecoration(hintText: 'email'),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28,0,28,0),
          child: TextField(
            controller: _passwordEditingController,
            decoration: InputDecoration(hintText: 'password'),
            obscureText: true,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28,0,28,0),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text('登录'),
              onPressed: _login,
            ),
          ),
        )
      ],
    );
  }

  _login(){
    String email = _emailEditingController.text;
    String password = _passwordEditingController.text;
    getHttp(email,password);
  }

  getHttp(String email,String password) async{
    DialogUtils.showLoading(context,"登录中...");
    NetUtils.instance.get(API_URL.PHONE_LOGIN, {"email":email,"password":password})
    .then((response){
      Navigator.pop(context);
      if(response != null){
        Map<String,dynamic> map = json.decode(response.toString());
        if(map['success']){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx)=>HomePage())
              ,(route) => route == null
          );
        }else{
          Fluttertoast.showToast(msg: "用户名或密码错误");
        }
      }

    },onError:(e){
      Log.e(e);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "网络访问出错");
    });

  }
}