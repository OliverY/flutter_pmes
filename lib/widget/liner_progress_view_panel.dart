import 'package:flutter/material.dart';
import 'dart:math' show pi;

class LinearProgress extends StatelessWidget {

  double height;
  int progress;
  EdgeInsets padding;


  LinearProgress(this.height, this.progress, this.padding);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: padding,
        child: CustomPaint(
          size: Size.fromHeight(height),
          painter: LinearProgressPainter(progress),
        ),
      ),
    );
  }

}

class LinearProgressPainter extends CustomPainter {

  Paint colorPaint;
  Paint bgPaint;

  int progress;

  LinearProgressPainter(this.progress)
      :
        colorPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = Color(0xFF40CE94)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1,
        bgPaint = Paint()
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.round
          ..color = Color(0xFFF4F3F3)
          ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    double dy = height / 2;

    int indexProgress = progress <= 10? 10 : progress;

    // 画背景
    Path bgPath = Path()
      ..moveTo(dy, 0)
      ..lineTo(width - dy, 0)
      ..arcTo(Rect.fromCircle(center: Offset(width - dy, dy), radius: dy), - pi / 2, pi, false)
      ..lineTo(dy, height)
      ..arcTo(Rect.fromCircle(center: Offset(dy, dy), radius: dy), pi / 2, pi,false)
      ..close();
    canvas.drawPath(bgPath, bgPaint);

    // 画前景
    Path indexPath = Path()
      ..moveTo(dy, 0)
      ..lineTo(width / 100 * indexProgress - dy, 0)
      ..arcTo(Rect.fromCircle(center: Offset(width / 100 * indexProgress - dy, dy), radius: dy), - pi / 2, pi, false)
      ..lineTo(dy, height)
      ..arcTo(Rect.fromCircle(center: Offset(dy, dy), radius: dy), pi / 2, pi,false)
      ..close();

    _switchColor();
    canvas.drawPath(indexPath, colorPaint);

    // 画文字
    _drawIndex(width, dy,indexProgress, canvas);
  }

  _switchColor() {
    if(progress>=0 && progress <= 30){
      colorPaint.color = Color(0XFFF42323);
    }else if(progress>30 && progress <= 60){
      colorPaint.color = Color(0XFFFBDA59);
    }else if(progress>60 && progress <= 100){
      colorPaint.color = Color(0XFF40CE94);
    }
  }

  _drawIndex(double width, double dy,int indexProgress, Canvas canvas) {
    TextPainter wordPainter = _createWordTextPainter();
    double offsetX = (width / 100 * indexProgress - dy - wordPainter.width/2)/2;
    double offsetY = dy - wordPainter.height/2;
    wordPainter.paint(canvas, Offset(offsetX,offsetY));
  }

  _createWordTextPainter() {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: "${progress.toString()}%",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        textDirection: TextDirection.ltr
    )
      ..textAlign = TextAlign.center
      ..layout();
    return textPainter;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }

}
