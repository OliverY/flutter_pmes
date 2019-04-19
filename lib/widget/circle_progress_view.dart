import 'package:PMES/widget/circle_progress_view_panel.dart';
import 'package:flutter/material.dart';

class CircleProgressView extends StatelessWidget{

  int color;
  int index;
  int sum;
  String words;

  CircleProgressView(@required this.color,@required this.index,@required this.sum,@required this.words);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: CircleProgressViewPanel(color,index,sum,words),
    );
  }

}