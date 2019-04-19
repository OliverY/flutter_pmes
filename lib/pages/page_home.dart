import 'dart:convert';

import 'package:PMES/bean/equipment.dart';
import 'package:PMES/config/config.dart';
import 'package:PMES/net/net_constants.dart';
import 'package:PMES/net/net_utils.dart';
import 'package:PMES/net/response_bean.dart';
import 'package:PMES/pages/page_schedule_logging.dart';
import 'package:PMES/pages/page_schedule_progress.dart';
import 'package:PMES/utils/log.dart';
import 'package:PMES/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return new Scaffold(
      body: Column(
        children: <Widget>[
          YAppBar("生成计划管理"),
          Container(
            child:Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 14.0, 15.0, 0),
              child: Image.asset('images/login_image.jpg',width: screenWidth - 30,height: (screenWidth - 30)*210/345,fit: BoxFit.fill,),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          SizedBox(
            width: double.infinity,
            height: 49,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
              child: RaisedButton(
                elevation:0,
                onPressed: ()=>_logging(context),
                //通过控制 Text 的边距来控制控件的高度
                child: Text("录入进度",style: TextStyle(color: Colors.white,fontSize: 18),),
                color: Color(0XFF15C160),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 37,
          ),
          SizedBox(
            width: double.infinity,
            height: 49,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
              child: RaisedButton(
                elevation:0,
                onPressed: ()=>_showProductProgress(context),
                //通过控制 Text 的边距来控制控件的高度
                child: Text("生产进度",style: TextStyle(color: Colors.white,fontSize: 18),),
                color: Color(0XFF429FFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    NetUtils.instance.get(API_URL.GET_CONFIG_INFO,null)
    .then((value){
      Map<String,dynamic> map = json.decode(value);
      ResponseBean responseBean = ResponseBean.fromJson(map);
      if(responseBean.success){
        Config.instance.configList = responseBean.data;
      }
    });
  }

  _logging(BuildContext context)async{

    String barcode = await BarcodeScanner.scan();
    print('good:$barcode');

    if(barcode == null){
      Fluttertoast.showToast(msg: "二维码扫描失败，请重试");
    }else{
      // 调用网络
      Stream.fromFuture(NetUtils.instance.get(API_URL.GET_DEVICE_INFO_BY_SCAN, {"barcode":barcode}))
          .listen((future) async{
        String data = await future;
        Map<String,dynamic> map = json.decode(data);
        Log.e("map::$map");
        EquipmentBean equipmentBean = EquipmentBean.fromJson(map['data']);

        Log.e("equipmentBean::$equipmentBean");

        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return ScheduleLoggingPage(equipmentBean);
        }));

      });
    }
  }


  _showProductProgress(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
      return ScheduleProgressPage();
    }));
  }
}