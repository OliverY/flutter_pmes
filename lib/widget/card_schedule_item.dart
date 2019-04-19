import 'package:PMES/bean/scheduler.dart';
import 'package:PMES/widget/circle_progress_view.dart';
import 'package:PMES/widget/liner_progress_view_panel.dart';
import 'package:flutter/material.dart';

class ScheduleCardItem extends StatelessWidget {

  SchedulerBean schedulerBean;

  ScheduleCardItem(this.schedulerBean);

  int _progress;

  @override
  Widget build(BuildContext context) {

    _progress = int.parse(schedulerBean.rate.replaceFirst("%", ""));

    return SizedBox(
      height: 270,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildItemTop(),
            _buildCircleProgress(),
            _buildLinearProgress(),
            Divider(),
            _buildTime(),
          ],
        ),
      ),
    );
  }

  SizedBox _buildTime() {
    return SizedBox(
              height: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14,0,0,5),
                    child: Text('开始时间：${schedulerBean.startTime}',style: TextStyle(fontSize: 14,color: Color(0XFF666666)),),
                  )
                ],
              )
            );
  }

  SizedBox _buildLinearProgress() {
    return SizedBox(
              height: 52,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0,0,14,0),
                    child: Text('进度',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  ),
                  LinearProgress(24,_progress,EdgeInsets.fromLTRB(0, 0, 14, 0)),
                ],
              ),
            );
  }

  SizedBox _buildCircleProgress() {
    return SizedBox(
              height: 108,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleProgressView(0xFF429FFF,schedulerBean.deviceNumber,schedulerBean.deviceNumber,"设备总数"),
                    CircleProgressView(0xFF6D81FD,schedulerBean.moduleInstalled,schedulerBean.deviceNumber,"模块安装"),
                    CircleProgressView(0xFFA68FFE,schedulerBean.deviceWired,schedulerBean.deviceNumber,"设备布线"),
                    CircleProgressView(0xFF429FFF,schedulerBean.deviceTested,schedulerBean.deviceNumber,"设备测试"),
                  ],
                ),
              ),
            );
  }

  SizedBox _buildItemTop() {
    return SizedBox(
              height: 44,
              child: Container(
                color: Color(0xFFF6FAFF),
                padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(schedulerBean.projectName,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                    Text(schedulerBean.deviceTypeDesc,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            );
  }
}


