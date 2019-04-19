import 'package:PMES/widget/dialog_loading.dart';
import 'package:flutter/material.dart';

class DialogUtils{

  static void showLoading(BuildContext context,String msg){
    showDialog(context:context,barrierDismissible:true,builder: (ctx)=>LoadingDialog(msg));
  }

}