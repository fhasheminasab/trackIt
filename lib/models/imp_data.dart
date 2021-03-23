
class ImpData {
  int id;
  DateTime date;
  // String date;
  int calorie = 0;
  int exercise = 0;
  int heart = 0;
  int water = 0;
  // BluetoothDevice device;

  static const String impTable = 'imp_table';
  static const String impId = 'id'; //does it need one?
  static const String impDate = 'date';
  static const String impCalorie = 'calorie'; // total calorie used in a day
  static const String impExercise = 'exercise'; // int 0to3
  static const String impHeart = 'heart'; //??
  static const String impWater = 'water'; //??
  // static const String impDeviceId = 'device_id';
  // static const String impDeviceName = 'device_name';
  // static const String impDeviceType = 'device_type';

  ImpData({
    this.date,
    this.calorie,
    this.exercise,
    this.heart,
    this.water,
    // this.device,
  });
  ImpData.withId({
    this.id,
    this.date,
    this.calorie,
    this.exercise,
    this.heart,
    this.water,
    // this.device,
  });

  //convert an instance to a map
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map[impId] = id;
    }
    map[impDate] = date.toIso8601String();
    // map['date'] = date;
    map[impCalorie] = calorie;
    map[impExercise] = exercise;
    map[impHeart] = heart;
    map[impWater] = water;
    // map[impDeviceId] = device.id.toString();
    // map[impDeviceName] = device.name;
    // map[impDeviceType] = device.type.toString();

    return map;
  }

  //convert a map into an instance
  factory ImpData.fromMap(Map<String, dynamic> map) {
    // BluetoothDeviceType t = BluetoothDeviceType.values.firstWhere(
    //   (e) => e.toString() == 'BluetoothDeviceType.' + map[impDeviceType],
    // );
    return ImpData.withId(
      id: map[impId],
      date: DateTime.parse(map[impDate]),
      // date: map['date'],
      calorie: map[impCalorie],
      exercise: map[impExercise],
      heart: map[impHeart],
      water: map[impWater],
      // device: BluetoothDevice(
      //   id: DeviceIdentifier(map[impDeviceId]),
      //   name: map[impDeviceName],
      //   type: t,
      // ),
    );
  }
}
