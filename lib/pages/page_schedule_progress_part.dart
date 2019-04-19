import 'dart:convert';

import 'package:PMES/bean/scheduler.dart';
import 'package:PMES/net/net_constants.dart';
import 'package:PMES/net/net_utils.dart';
import 'package:PMES/net/response_bean.dart';
import 'package:PMES/utils/log.dart';
import 'package:PMES/widget/card_schedule_item.dart';
import 'package:flutter/material.dart';

class ScheduleList extends StatefulWidget {

  int _status;

  ScheduleList(this._status);

  @override
  ScheduleListState createState() => new ScheduleListState();
}

class ScheduleListState extends State<ScheduleList>
with AutomaticKeepAliveClientMixin{

  String _errorMsg;
  bool isLoading = true;
  List<SchedulerBean> _schedulerList;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        return await _getScheduleData(widget._status);
      },
      child: _buildTabViewLayout(),
    );
  }

  Widget _buildTabViewLayout(){
    if(isLoading){
      return _buildLoading();
    }

    if(_schedulerList == null || _schedulerList.isEmpty){
      return _buildEmpytView(_errorMsg);
    }else{
      return _buildListView();
    }
  }

  Widget _buildLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListView(){
    return ListView.builder(
      itemBuilder: (ctx,index)=>ScheduleCardItem(_schedulerList[index]),
      itemCount: _schedulerList.length,
      padding:EdgeInsets.all(10),
    );
  }

  Widget _buildEmpytView(String msg){
    return Container(
      child: Center(
        child: Text(
            msg,
            style:TextStyle(
                fontSize: 18
            )
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getScheduleData(widget._status);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getScheduleData(int status)async {
    Log.e("status:$status");
    isLoading = true;
    await NetUtils.instance.get(API_URL.GET_PRODUCE_PLAN_PROCESS, {"planStatus":status})
        .then((response){
      isLoading = false;

      ResponseBean responseBean = ResponseBean.fromJson(json.decode(response));
      if(responseBean.success){
        if(mounted){
          setState(() {
            _schedulerList = (responseBean.data as List).map((e)=>SchedulerBean.fromJson(e)).toList();
          });
        }
      }else{
        setState(() {
          _errorMsg = responseBean.msg;
        });
      }
    });
    return null;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}