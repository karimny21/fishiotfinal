class IotModel {
// Field
  int setled, setwater, setfood, statusled, mode; //setair,

//Constructor
  IotModel(
      this.setled,
      this.setwater,
      this.setfood,
      this.mode, //this.setair,
      this.statusled);

  IotModel.formMap(Map<dynamic, dynamic> mapset) {
    setled = mapset['setled'];
    setwater = mapset['setwater'];
    setfood = mapset['setfood'];
    statusled = mapset['statusled'];
    // setair = mapset['setair'];
    mode = mapset['mode'];
  }

  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> mapset = Map<dynamic, dynamic>();
    mapset['setled'] = setled;
    mapset['setwater'] = setwater;
    mapset['setfood'] = setfood;
    mapset['statusled'] = statusled;
    // mapset['setair'] = setair;
    mapset['mode'] = mode;

    return mapset;
  }
}

class IoTData {
  int settime, setminute; //,setTemp ,maxPh ,minPh

  IoTData(
    this.settime,
    this.setminute,
    // this.setTemp,this.maxPh,this.minPh,
  ); //

  IoTData.formMap(Map<dynamic, dynamic> mapset) {
    settime = mapset['settime'];
    setminute = mapset['setminute'];
    // setTemp = mapset['setTemp'];
    // minPh = mapset['minPh'];
    // maxPh = mapset['maxPh'];
  }

  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> mapset = Map<dynamic, dynamic>();
    mapset['settime'] = settime;
    mapset['setminute'] = setminute;
    // mapset['setTemp'] = setTemp;
    // mapset['minPh'] = minPh;
    // mapset['maxPh'] = maxPh;
    return mapset;
  }
}

class IoTPH {
  int maxPh, minPh; //setTemp

  IoTPH(this.maxPh, this.minPh); //, this.setTemp

  IoTPH.formMap(Map<dynamic, dynamic> mapset) {
    maxPh = mapset['maxPh'];
    minPh = mapset['minPh'];
    // setTemp = mapset['setTemp'];
  }

  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> mapset = Map<dynamic, dynamic>();
    mapset['maxPh'] = maxPh;
    mapset['minPh'] = minPh;
    return mapset;
  }
}

class IoTTurbidity {
  int maxTurbidity, minTurbidity; //setTemp

  IoTTurbidity(this.maxTurbidity, this.minTurbidity); //, this.setTemp

  IoTTurbidity.formMap(Map<dynamic, dynamic> mapset) {
    maxTurbidity = mapset['maxTurbidity'];
    minTurbidity = mapset['minTurbidity'];
  }

  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> mapset = Map<dynamic, dynamic>();
    mapset['maxTurbidity'] = maxTurbidity;
    mapset['minTurbidity'] = minTurbidity;
    return mapset;
  }
}

class IoTTemp {
  int maxTemp, minTemp; //setTemp

  IoTTemp(this.maxTemp, this.minTemp); //, this.setTemp

  IoTTemp.formMap(Map<dynamic, dynamic> mapset) {
    maxTemp = mapset['maxTemp'];
    minTemp = mapset['minTemp'];
  }

  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> mapset = Map<dynamic, dynamic>();
    mapset['maxTemp'] = maxTemp;
    mapset['minTemp'] = minTemp;
    return mapset;
  }
}
