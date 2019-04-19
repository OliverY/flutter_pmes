import 'package:PMES/widget/app_bar.dart';
import 'package:PMES/widget/card_schedule_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleProgressPage extends StatefulWidget {
  @override
  ScheduleProgressPageState createState() => new ScheduleProgressPageState();
}

class ScheduleProgressPageState extends State<ScheduleProgressPage> with SingleTickerProviderStateMixin{

  List _tabTitles = ['进行中', '已完成'];

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          YAppBar("生成进度"),
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
                tabs: _tabTitles.map((title) {
                  return Tab(
                    child: Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                  );
                }).toList()),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildLatestTweetList(), _buildHotTweetList()],
            ),
          )
          //list
        ],
      ),
    );
  }

  Widget _buildLatestTweetList() {
    return ListView.builder(
        itemBuilder: (ctx,index)=>ScheduleCardItem(),
        itemCount: 5,
        padding:EdgeInsets.all(10),
    );
  }

  Widget _buildHotTweetList() {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  }

}