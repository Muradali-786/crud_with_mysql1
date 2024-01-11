import 'package:mysql1/mysql1.dart';

class MySql {
  static String host = '15.204.0.108',
      user = 'easysoft_murad',
      password = '.QI4OZOEre@d',
      db = 'easysoft_easysoft2';

  static int port = 3306;

  Future<MySqlConnection> get connection async {
    return await MySqlConnection.connect(ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    ));
  }

  Future<List<dynamic>> fetchPatients() async {
    final conn = await connection;
    try {
      final results = await conn.query('SELECT * FROM Patients');
      return results.map((row) => row).toList();
    } finally {
      await conn.close();
    }
  }

  Future<void> updatePatient(int id, String name, int age, String doctorName,
      String description, int charges) async {
    final conn = await connection;
    try {
      await conn.query(
          'UPDATE Patients SET name = ?, age = ?, doctorName = ?, description = ?, charges = ? WHERE id = ?',
          [name, age, doctorName, description, charges, id]);
    } finally {
      await conn.close();
    }
  }
  Future<void> grantDeletePermission() async {
    String username = "easysoft_murad" + "@" + "223.123.87.11";
    final conn = await connection;
    try {
      await conn.query('GRANT DELETE ON easysoft_easysoft2.Patients TO ${username}');
    } catch (e) {
      print('Error granting DELETE permission: $e');
      // Handle the error as needed
    } finally {
      await conn.close();
    }
  }



  Future<void> deletePatient(int id) async {
    final conn = await connection;
    try {
      await conn.query('DELETE FROM Patients WHERE id = ?', [id]);
    } finally {
      await conn.close();
    }
  }

  Future<void> insertPatient(String name, int age, String doctorName,
      String description, int charges) async {
    final conn = await connection;
    try {
      await conn.query(
          'INSERT INTO Patients (name, age, doctorName, description, charges) VALUES (?, ?, ?, ?, ?)',
          [name, age, doctorName, description, charges]);
    } finally {
      await conn.close();
    }
  }
}
