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

  ConfigLayout _configLayout;

  set configList(Map<String,dynamic> map) => _configLayout = ConfigLayout.fromJson(map);

  /**
   * 过程选项
   */
  List<ConfigBean> get stages => _configLayout.stageList;

  /**
   * 阶段
   */
  List<ConfigBean> get progresses => _configLayout.progressList;

}

class ConfigLayout{

  List<ConfigBean> _typeId_121;
  List<ConfigBean> progressList; //阶段
  List<ConfigBean> stageList; //过程选项

  ConfigLayout.fromJson(Map<String,dynamic> map){
    _typeId_121 = (map['typeId_121'] as List).map((e)=>ConfigBean.fromJson(e)).toList();
    progressList = (map['typeId_122'] as List).map((e)=>ConfigBean.fromJson(e)).toList();
    stageList = (map['typeId_123'] as List).map((e)=>ConfigBean.fromJson(e)).toList();
  }

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