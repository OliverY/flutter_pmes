class ResponseBean<T>{
  bool success;
  String msg;
  T data;

  ResponseBean.fromJson(Map<String,dynamic> map):
      success = map['success'],
        msg = map['msg'],
        data = map['data'];

}