class Config{

  factory Config()=>_getInstance();
  static Config get instance => _getInstance();
  static Config _instance;
  Config._internal();

  static Config _getInstance(){
    if(_instance == null){
      _instance = Config._internal();
    }
    return _instance;
  }

  List<ConfigBean> _configList;

  set configList(List<ConfigBean> configList) => _configList = configList;

  /**
   * 过程选项
   */
  List<ConfigBean> get stages => List.from(_configList.where((config)=>config.typeId == 123));

  /**
   * 阶段
   */
  List<ConfigBean> get progresses => List.from(_configList.where((config)=>config.typeId == 122));

}


class ConfigBean{
  int id;
  int typeId;
  String describe;

  ConfigBean(this.id, this.typeId, this.describe);

  ConfigBean.fromJson(Map<String,dynamic> map):
      id = map['id'],
      typeId = map['typeId'],
      describe = map['describe'];

  @override
  String toString() {
    return 'Config{id: $id, typeId: $typeId, describe: $describe}';
  }


}