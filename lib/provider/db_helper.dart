// import 'dart:html';
import 'dart:io';
import 'package:network_sqflite/model/user_model2.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'employee_manager.db');
    return await openDatabase(path,
        version: 1,
        onUpgrade: _onUpgrade,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Employee ("
          "id INTEGER PRIMARY KEY,"
          "email TEXT,"
          "username TEXT,"
          "name TEXT,"
          "phone TEXT,"
          "address TEXT"
          ")");

      await db.execute('CREATE TABLE Address('
          'id INTEGER,'
          'street TEXT,'
          'suite TEXT,'
          'city TEXT,'
          'zipcode TEXT,'
          ' FOREIGN KEY (id) REFERENCES Employee (id)'
          ')');
      await db.execute('CREATE TABLE Company('
          'C_id INTEGER,'
          'name TEXT,'
          'catchPhrase TEXT,'
          'bs TEXT,'
          ' FOREIGN KEY (C_id) REFERENCES Employee (id)'
          ')');

    });
  }

  createEmployee(Employee newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db.insert('Employee', {
      'id': newEmployee.id,
      'email': newEmployee.email,
      'username': newEmployee.username,
      'name': newEmployee.name,
      'phone': newEmployee.phone,
    });
    Address newAddress = newEmployee.address;
    final addressResult = await db.insert('Address', {
      'city': newAddress.city,
      'street': newAddress.street,
      'suite': newAddress.suite,
      'zipcode': newAddress.zipcode,
      'id': newEmployee.id,
    });

    Company newComp = newEmployee.company;
    final compResult = await db.insert('Company', {
      'name': newComp.name,
      'catchPhrase': newComp.catchPhrase,
      'bs': newComp.bs,
      'C_id': newEmployee.id,
    });
    return res;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE Employee ADD COLUMN address TEXT;");
    }
  }

  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Employee');

    return res;
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT Employee.id,Employee.name,Employee.username,Employee.email,Employee.phone,Address.street,Address.suite,Address.city,Address.zipcode,Company.name FROM Employee INNER JOIN Address  on Employee.id=Address.id INNER JOIN Company on Employee.id=Company.C_id ");

    List<Employee> list = res.isNotEmpty
        ? res.map((c) {
            final employee = Employee.fromJson(c);
            employee.address = Address.fromJson(c);
            employee.company=Company.fromJson(c);
            return employee;
          }).toList()
        : [];
    return list;
  }
}
