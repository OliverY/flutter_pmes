import 'package:PMES/utils/log.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show window;

class YAppBar extends StatelessWidget {

  final String title;
  final Function back;

  YAppBar(this.title,{this.back});

  @override
  Widget build(BuildContext context) {

    double statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
    Log.e("statusBarHeight=$statusBarHeight");

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: statusBarHeight,
          width: screenWidth,
        ),
        SizedBox(
          height: 44,
          child: Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13,0,13,0),
                    child: Icon(Icons.close,size: 20,),
                  ),
                  onTap: ()=>_onTap(context),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                  child: Text(title,style: TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                )
              ],
            ),
          ),
        ),
        Divider(height: 1,)
      ],
    );
  }

  void _onTap(BuildContext context) {
    if(back == null){
      Navigator.of(context).pop();
    }else{
      back();
    }
  }
}