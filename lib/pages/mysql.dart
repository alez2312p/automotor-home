import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '10.1.1.16',
                user = 'root',
                password = "",
                db = 'automotor';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      user: user,
      password: password,
      db: db,
      port: port,
    );
    return await MySqlConnection.connect(settings);
  }
}
