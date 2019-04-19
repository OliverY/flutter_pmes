import 'package:flutter/material.dart';

class LoadingDialog extends Dialog{
  String text;

  LoadingDialog(this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 120,
          height: 120,
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Text(
                    text,
                    style:TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}