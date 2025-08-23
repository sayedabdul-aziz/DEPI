import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/models/task_model.dart';

class LocalHelper {
  static late Box _userBox;
  static late Box<TaskModel> _taskBox;

  static Box<TaskModel> get taskBox => _taskBox;

  static Box get userBox => _userBox;

  static String kUserBox = 'user';
  static String kTaskBox = 'task';

  static String kName = 'name';
  static String kImage = 'image';
  static String kIsUpload = 'isUpload';
  static String kIsDark = 'isDark';

  static init() async {
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    await Hive.openBox(kUserBox);
    await Hive.openBox<TaskModel>(kTaskBox);
    _userBox = Hive.box(kUserBox);
    _taskBox = Hive.box<TaskModel>(kTaskBox);
  }

  static cacheData(String key, dynamic value) {
    _userBox.put(key, value);
  }

  static getData(String key) {
    return _userBox.get(key);
  }

  static cacheTask(String key, TaskModel task) {
    _taskBox.put(key, task);
  }

  static getTask(String key) {
    return _taskBox.get(key);
  }
}
