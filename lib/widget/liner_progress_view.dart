import 'package:PMES/widget/liner_progress_view_panel.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('progress'),
        elevation: 0,
      ),
      body: Container(
        height: 50,
        color:Colors.grey,
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child:Padding(
                padding: const EdgeInsets.fromLTRB(14,0,0,0),
                child: Text('hello'),
              )
            ),
            LinearProgress(40,60,EdgeInsets.fromLTRB(14, 0, 14, 0))
          ],
        ),
      ),
    );
  }
}