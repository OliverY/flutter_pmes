import 'dart:convert';

import 'package:PMES/bean/equipment.dart';
import 'package:PMES/config/config.dart';
import 'package:PMES/net/net_constants.dart';
import 'package:PMES/net/net_utils.dart';
import 'package:PMES/utils/log.dart';
import 'package:PMES/widget/app_bar.dart';
import 'package:flutter/material.dart';

class ScheduleLoggingPage extends StatefulWidget {

  EquipmentBean _equipmentBean;

  ScheduleLoggingPage(this._equipmentBean);

  @override
  ScheduleLoggingPageState createState() => new ScheduleLoggingPageState();
}

class ScheduleLoggingPageState extends State<ScheduleLoggingPage> {

  List<ConfigBean> _stageList;

  int _stage;// 阶段

  @override
  void initState() {
    super.initState();

    _stageList = Config.instance.stages;
  }

  @override
  Widget build(BuildContext context) {

    Log.e("logging page:${widget._equipmentBean}");

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            YAppBar("登记进度"),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  _buildNormalItem("设备类型",widget._equipmentBean.deviceTypeDesc),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
                    child: Divider(height: 1,color: Color(0XFFAAAAAA),),
                  ),
                  _buildNormalItem("设备型号",widget._equipmentBean.deviceTypeName),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
                    child: Divider(height: 1,color: Color(0XFFAAAAAA),),
                  ),
                  _buildNormalItem("设备条形码",widget._equipmentBean.barcode),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
                    child: Divider(height: 1,color: Color(0XFFAAAAAA),),
                  ),
                  _buildSelectItem("阶段",_getStage(_stage)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
                    child: Divider(height: 1,color: Color(0XFFAAAAAA),),
                  ),
                  _buildNormalItem("医院",widget._equipmentBean.hospitalName),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0,0,0),
                    child: Divider(height: 1,color: Color(0XFFAAAAAA),),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 49,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                child: RaisedButton(
                  elevation:0,
                  onPressed: ()=>_sure(context),
                  //通过控制 Text 的边距来控制控件的高度
                  child: Text('确定',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                  color: Color(0XFF429FFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 63,
            )
          ],
        ),
      ),
    );
  }

  String _getStage(int index){
     List<ConfigBean> result = List.from(_stageList.where((config)=>config.id == index));
     if(result == null || result.isEmpty){
       return "请选择阶段";
     }else{
       return result.first.describe;
     }
  }

  _buildNormalItem(String title,String value){
    return SizedBox(
      height: 46,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15,0,0,0),
            child: Text(title,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,15,0),
            child: Text(value,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:Color(0XFF999999))),
          ),
        ],
      ),
    );
  }

  _buildSelectItem(String title,String value){
    return SizedBox(
      height: 46,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15,0,0,0),
            child: Text(title,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,15,0),
            child: InkWell(
              onTap: ()=>_chooseStage(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(value,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:Color(0XFF666666))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(21,0,0,0),
                    child: Icon(Icons.expand_more),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _chooseStage(context){
    showModalBottomSheet(context: context, builder:(ctx){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildChooseLayout(),
        );
      }
    );
  }

  List<Widget> _buildChooseLayout(){
    return _stageList.map((config){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildChooseStageItem(config),
          Divider(height:1),
        ],
      );
    }).toList();
  }

  Widget _buildChooseStageItem(ConfigBean config){
    return InkWell(
      onTap: (){
        setState(() {
          _stage = config.id;
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 54,
        child: Center(
          child:Text(
            config.describe
          ),
        ),
      ),
    );
  }

  _sure(BuildContext context){
    Map<String,dynamic> params = {
      'barCode':widget._equipmentBean.barcode,
      'planOnwardStatus':_stage,
      'deviceId':widget._equipmentBean.id,
      'projectId':widget._equipmentBean.hospitalId,
    };
    Log.e(params);

    NetUtils.instance.post(API_URL.LOGGING_SCHEDULE,params)
      .then((response){
        Log.e(response);
      Map<String,dynamic> map = json.decode(response);
      if(map['success']){
        Navigator.pop(context);
      }
    });
  }
}