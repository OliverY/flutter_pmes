import 'package:flutter/material.dart';
import 'dart:math';

class CircleProgressViewPanel extends CustomPainter{

  Paint circlePaint;
  Paint bgCirclePaint;

  int index;
  int sum;
  String words;

  CircleProgressViewPanel(int circleColor,this.index,this.sum,this.words):
        circlePaint = Paint()
          ..color = Color(circleColor)
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke,
        bgCirclePaint = Paint()
          ..color = Color(0xFFF4F4F4)
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {

    Rect rect = Rect.fromLTRB(-30, -30, 30, 30);
    canvas.drawArc(rect, pi*5/6, pi*4/3, false, bgCirclePaint);
    canvas.drawArc(rect, pi*5/6, pi*4/3*(index*1.0/sum), false, circlePaint);

    _createIndexTextPainter().paint(canvas, Offset((-5.0*(index.toString().length)),-15/2));
    _createWordTextPainter().paint(canvas, Offset(-30,25));
  }

  _createIndexTextPainter(){
    TextPainter textPainter = TextPainter(
        text:TextSpan(
            text:index.toString(),
            style:TextStyle(
                color:Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w600
            )
        ),
        maxLines: 1,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    )..layout(minWidth:0,maxWidth: 50);
    return textPainter;
  }

  _createWordTextPainter(){
    TextPainter textPainter = TextPainter(
        text:TextSpan(
            text:words,
            style:TextStyle(
                color:Color(0xFF666666),
                fontSize: 15.0,
                fontWeight: FontWeight.w400
            )
        ),
        maxLines: 1,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    )..layout();
    return textPainter;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}