import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io' show Platform;

class Database {
  String host = Platform.environment['MONGO_DART_DRIVER_HOST'] ?? '127.0.0.1';
  String port = Platform.environment['MONGO_DART_DRIVER_PORT'] ?? '27017';

  void dbconection() async {
    var db = await Db.create(
        "mongodb+srv://<user>:<password>@<host>:<port>/<database-name>?<parameters>");
    await db.open();
  }
}
