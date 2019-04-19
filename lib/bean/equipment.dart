class EquipmentBean{

  int id;
  String barcode;
  String deviceTypeName;  //设备型号
  int hospitalId;         //项目id
  String hospitalName;
  int deviceType;         //设备类型（1，2）
  String deviceTypeDesc;  //设备类型（自助机、诊间屏）

  EquipmentBean();

  EquipmentBean.fromJson(Map<String,dynamic> map)
      :id = map['id'],
        barcode = map['barcode'],
      deviceTypeName = map['deviceTypeName'],
      hospitalId = map['hospitalId'],
      hospitalName = map['hospitalName'],
      deviceType = map['deviceType'],
      deviceTypeDesc = map['deviceTypeDesc'];

  Map<String,dynamic> toJson()=>
      {
        'id':id,
        'barcode':barcode,
        'deviceTypeName':deviceTypeName,
        'hospitalId':hospitalId,
        'hospitalName':hospitalName,
        'deviceType':deviceType,
        'deviceTypeDesc':deviceTypeDesc,
      };

  @override
  String toString() {
    return 'EquipmentBean{id: $id, barCode: $barcode, deviceTypeName: $deviceTypeName, hospitalId: $hospitalId, hospitalName: $hospitalName, deviceType: $deviceType, deviceTypeDesc: $deviceTypeDesc}';
  }

}