class SchedulerBean{
  int id;
  String projectName; // 医院名称
  String deviceTypeDesc;  // 设备类型 诊间屏
  int deviceNumber; // 设备总数
  int moduleInstalled;  // 模块安装
  int deviceWired;  // 设备布线
  int deviceTested; // 设备测试
  String rate;// 进度
  String startTime;// 开始时间

  SchedulerBean.fromJson(Map<String,dynamic> map):
      id = map['id'],
        projectName = map['projectName'],
        deviceTypeDesc = map['deviceTypeDesc'],
        deviceNumber = map['deviceNumber'],
        moduleInstalled = map['moduleInstalled'],
        deviceWired = map['deviceWired'],
        deviceTested = map['deviceTested'],
        rate = map['rate'],
        startTime = map['startTime'];

}