import 'dart:convert';

import 'package:PMES/bean/scheduler.dart';
import 'package:PMES/config/config.dart';
import 'package:PMES/net/net_constants.dart';
import 'package:PMES/net/net_utils.dart';
import 'package:PMES/net/response_bean.dart';
import 'package:PMES/pages/page_schedule_progress_part.dart';
import 'package:PMES/utils/log.dart';
import 'package:PMES/widget/app_bar.dart';
import 'package:PMES/widget/card_schedule_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleProgressPage extends StatefulWidget {
  @override
  ScheduleProgressPageState createState() => new ScheduleProgressPageState();
}

class ScheduleProgressPageState extends State<ScheduleProgressPage> with SingleTickerProviderStateMixin{

  List<ConfigBean> _tabTitles;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabTitles = Config.instance.progresses;
    _tabController = TabController(length: _tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void didUpdateWidget(ScheduleProgressPage oldWidget) {
    super.didUpdateWidget(oldWidget);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          YAppBar("生产进度"),
          //tabbar
          Container(
            color: Colors.white,
            child: TabBar(
                controller: _tabController,
                indicatorColor: Color(0xff429FFF),
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.black,
                labelColor: Color(0xff429FFF),
                indicatorWeight: 3,
                tabs: _tabTitles.map((config) {
                  return Tab(
                    child: Text(config.describe,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                  );
                }).toList()),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabTitles.map((config)=>ScheduleList(config.id)).toList(),
            ),
          )
          //list
        ],
      ),
    );
  }

}