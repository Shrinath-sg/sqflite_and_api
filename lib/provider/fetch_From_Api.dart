import 'package:dio/dio.dart';
import 'package:network_sqflite/model/user_model2.dart';
import 'package:network_sqflite/provider/db_helper.dart';

class EmployeeApiProvider {
  Future<List<Employee>> getAllEmployees() async {
    var url = "https://jsonplaceholder.typicode.com/users";
    Response response = await Dio().get(url);

    return (response.data as List).map((employee) {
      print('Inserting $employee');
      DBProvider.db.createEmployee(Employee.fromJson(employee));
    }).toList();
  }
}
