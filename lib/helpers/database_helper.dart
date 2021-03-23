import 'package:sqflite/sqflite.dart';
import '../models/settings.dart';
import '../providers/imp_data_provider.dart';
import '../models/exercise.dart';
import '../models/imp_data.dart';
import '../models/heart_data.dart';
import '../providers/exercise_provider.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

//....................................................

// TODO: transfere these to models later

//important data lables: (record everyday status)
  static const String impTable = 'imp_table';
  static const String impId = 'id'; //does it need one?
  static const String impDate = 'date';
  static const String impCalorie = 'calorie'; // total calorie used in a day
  static const String impExercise = 'exercise'; // int 0to3
  static const String impheart = 'heart'; //int
  static const String impWater = 'water'; //int

  // static const String impDeviceId = 'device_id';
  // static const String impDeviceName = 'device_name';
  // static const String impDeviceType = 'device_type';

  // Heart Tables
  // Id | Date | calorie | exersice| heart | water
  // 0     ''       ''
  // 2     ''       ''
  // 3     ''       ''

//-----------------------
//Settings:
  static const String settingsTable = 'settings_table'; //int
  static const String settingsId = 'id'; //int
  static const String settingsheartRateAlert = 'heart_rate_alert'; //int
  static const String settingsWaterGoal = 'water_goal'; //int
  static const String settingsSMSNumber = 'sms_number'; //String
  static const String settingsSMSNumberisoCode = 'sms_number_isocode'; //String
  static const String settingsSMSText = 'sms_text'; //String
  static const String settingsCallNumber = 'call_number'; //String
  static const String settingsCallNumberisoCode = 'call_number_isocode'; //String
  static const String settingsSendSMS = 'send_sms'; //int
  static const String settingsMakeCall = 'make_call'; //int
//-----------------------

//table to see if each Exercise Pack is done:
  static const String exDoneTable = 'exdone_table';
  static const String exDoneId = 'id';
  static const String exDoneDone = 'done';
  static const String exDoneDescription = 'description';

//-----------------------

//heart rate lables:
  static const String heartTable = 'heart_table';
  static const String heartId = 'id';
  static const String heartRate = 'rate';
  static const String heartDate = 'date';

  // Heart Tables
  // Id | rate | Date
  // 0     ''      ''
  // 2     ''      ''
  // 3     ''      ''

//-----------------------

//heart rate lables:
  static const String exerciseTable = 'exercise_table';
  static const String exerciseId = 'id';
  static const String exerciseTitle = 'title';
  static const String exerciseImageUrl = 'image_url';
  static const String exerciseDescription = 'description';
//-----------------------

//Song lables:
  // static const String songTable = 'song_table';
  // static const String songtId = 'id';
  // static const String songtTitle = 'title';
  // static const String songtArtist = 'artist';

//....................................................
//db stuff:

  Future<void> insertInitData() async {
    await insertExercises();
    await insertGetDones();
    await insertSettings((ImpDataProvider().settings));
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    final dir = await getDatabasesPath(); //this
    String path2 = path.join(dir, 'trackit.db'); //and this
    // instead of these:
    // String path = dir.path2 + '/trackit.db';
    // Directory dir = await getApplicationDocumentsDirectory();
    final trackitDb = await openDatabase(
      path2,
      version: 1,
      onCreate: _createDb,
    );
    return trackitDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $impTable($heartId INTEGER PRIMARY KEY AUTOINCREMENT, $impDate TEXT, $impCalorie INTEGER, $impExercise INTEGER, $impheart INTEGER, $impWater INTEGER)',
      // , $impDeviceId TEXT, $impDeviceName TEXT, $impDeviceType TEXT
    );
    await db.execute(
      'CREATE TABLE $settingsTable($settingsId INTEGER PRIMARY KEY AUTOINCREMENT, $settingsheartRateAlert INTEGER, $settingsWaterGoal INTEGER, $settingsSMSNumber TEXT, $settingsCallNumber TEXT, $settingsSendSMS INTEGER, $settingsMakeCall INTEGER, $settingsSMSText TEXT, $settingsSMSNumberisoCode TEXT, $settingsCallNumberisoCode TEXT)',
    );
    await db.execute(
      'CREATE TABLE $heartTable($heartId INTEGER PRIMARY KEY AUTOINCREMENT, $heartRate INTEGER, $heartDate TEXT)',
    );
    // await db.execute(
    //   'CREATE TABLE $songTable($songtId INTEGER PRIMARY KEY AUTOINCREMENT, $songtTitle TEXT, $songtArtist TEXT)',
    // );
    await db.execute(
      'CREATE TABLE $exerciseTable($exerciseId INTEGER PRIMARY KEY AUTOINCREMENT, $exerciseTitle TEXT, $exerciseImageUrl TEXT, $exerciseDescription TEXT)',
    );
    await db.execute(
      'CREATE TABLE $exDoneTable($exDoneId INTEGER PRIMARY KEY AUTOINCREMENT, $exDoneDone INTEGER, $exDoneDescription TEXT)',
    );
  }

//....................................................
//querries:

  Future<int> isFirstTime() async {
    Database db = await this.db;
    //if exerciseTable has data then it's not the first tie the app is being opened:
    final List<Map<String, dynamic>> result = await db.query(exerciseTable);
    if (result.toString() == '[]') {
      return 1;
    } else
      return 0;
  }

  Future<int> impDataIsEmpty() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(impTable);
    if (result.toString() == '[]') {
      return 0;
    } else
      return 1;
  }

  //input this func with table names like: heartTable
  Future<List<Map<String, dynamic>>> _getTableMapList(String table) async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(table);
    return result;
  }

  // //input this func with table names like "heartTable"
  // //  and a dataType like "HeartData" and use like:
  // //  getTableList<HeartData>(heartTable)
  // Future<List<T>> getTableList<T>(String table) async {
  //   final List<Map<String, dynamic>> tableMapList =
  //       await getTableMapList(table);
  //   final List<T> tableList = [];
  //   tableMapList.forEach((tableMap) {
  //     tableList.add(T.fromMap(tableMap));
  //   });
  //   tableList.sort((itemA, itemB) => itemA.date.compareTo(itemB.date));
  //   return tableList;
  // }

//....................................................
  //impData queries:
  Future<ImpData> getImpDataOfTheDay() async {
    final List<ImpData> impDataList = await getImpDataList();
    final int length = impDataList.length;
    return impDataList[length - 1]; //PROBLEM? with -1
  }

  Future<List<ImpData>> getImpDataList() async {
    final List<Map<String, dynamic>> impDataMapList =
        await _getTableMapList(impTable);
    final List<ImpData> impDataList = [];
    impDataMapList.forEach((impDataMap) {
      impDataList.add(ImpData.fromMap(impDataMap));
    });
    // impDataList.sort((itemA, itemB) => itemA.date.compareTo(itemB.date));
    return impDataList;
  }

  Future<int> insertImpData(ImpData impData) async {
    Database db = await this.db;
    final int result = await db.insert(impTable, impData.toMap());
    return result;
  }

  Future<int> updateImpData(ImpData impData) async {
    Database db = await this.db;
    final int result = await db.update(
      impTable,
      impData.toMap(),
      where: '$impId = ?',
      whereArgs: [impData.id],
    );
    return result;
  }

//....................................................
  //Settings queries:
  Future<Settings> getSettings() async {
    final List<Settings> settingsList = await getSettingsList();
    final int length = settingsList.length;
    return settingsList[length - 1]; //PROBLEM? with -1
  }

  Future<List<Settings>> getSettingsList() async {
    final List<Map<String, dynamic>> settingsMapList =
        await _getTableMapList(settingsTable);
    final List<Settings> settingsList = [];
    settingsMapList.forEach((settingsMap) {
      settingsList.add(Settings.fromMap(settingsMap));
    });
    return settingsList;
  }

  Future<int> insertSettings(Settings settings) async {
    Database db = await this.db;
    final int result = await db.insert(settingsTable, settings.toMap());
    return result;
  }

  Future<int> updateSettings(Settings settings) async {
    Database db = await this.db;
    final int result = await db.update(
      settingsTable,
      settings.toMap(),
      where: '$impId = ?',
      whereArgs: [settings.id],
    );
    return result;
  }

//....................................................
  //heartData queries:
  Future<List<HeartData>> getHeartDataList() async {
    final List<Map<String, dynamic>> heartDataMapList =
        await _getTableMapList(heartTable);
    final List<HeartData> heartDataList = [];
    heartDataMapList.forEach((heartDataMap) {
      heartDataList.add(HeartData.fromMap(heartDataMap));
    });
    // heartDataList.sort((itemA, itemB) => itemA.date.compareTo(itemB.date));
    return heartDataList;
  }

  Future<int> insertHeartData(HeartData heartData) async {
    Database db = await this.db;
    final int result = await db.insert(heartTable, heartData.toMap());
    return result;
  }

  Future<int> updateheartData(HeartData heartData) async {
    Database db = await this.db;
    final int result = await db.update(
      heartTable,
      heartData.toMap(),
      where: '$heartId = ?',
      whereArgs: [heartData.id],
    );
    return result;
  }

  Future<int> deleteHeartData(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      heartTable,
      where: '$heartId = ?',
      whereArgs: [id],
    );
    return result;
  }

//....................................................
//exercise queries:
  Future<int> insertExercise(Exercise exercise) async {
    Database db = await this.db;
    final int result = await db.insert(
      exerciseTable,
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<void> insertExercises() async {
    await Future.forEach(ExerciseProvider().items, (ex) async {
      await insertExercise(ex);
    }); //if that didn't work, this one will:

    // ExerciseProvider().items.forEach((ex) async {
    //   await insertExercise(ex);
    // });
  }

  Future<List<Exercise>> getExerciseList() async {
    final List<Map<String, dynamic>> exerciseMapList =
        await _getTableMapList(exerciseTable);
    final List<Exercise> exerciseList = [];
    exerciseMapList.forEach((exerciseMap) {
      exerciseList.add(Exercise.fromMap(exerciseMap));
    });
    return exerciseList;
  }

//....................................................
//exDone queries:

  Future<List<ExercisePack>> getExDoneList() async {
    final List<Map<String, dynamic>> exDoneMapList =
        await _getTableMapList(exDoneTable);
    final List<ExercisePack> exDoneList = [];
    exDoneMapList.forEach((exDoneMap) {
      exDoneList.add(ExercisePack.fromMap(exDoneMap));
    });
    return exDoneList;
  }

  Future<int> updateExDone(ExercisePack exDone) async {
    Database db = await this.db;
    final int result = await db.update(
      exDoneTable,
      exDone.toMap(),
      where: '$exDoneId = ?',
      whereArgs: [exDone.id],
    );
    return result;
  }

  Future<int> insertGetDone(ExercisePack exp) async {
    Database db = await this.db;
    final int result = await db.insert(
      exDoneTable,
      exp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<void> insertGetDones() async {
    await Future.forEach(ExerciseProvider().exDoneItems, (exp) async {
      await insertGetDone(exp);
    });
  }
}
