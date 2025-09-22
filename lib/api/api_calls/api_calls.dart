import 'package:task_manager/network/network_service.dart';

class NetworkRepository {
  ApiService _obj = ApiService();

  Future<Map<String, dynamic>> userLogin(Map<String, dynamic> param) async {
    try {
      var response = await _obj.postData('login', param);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> userRegisteration(
      Map<String, dynamic> param) async {
    try {
      var response = await _obj.postData('register', param);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUsers() async {
    try {
      var response = await _obj.getData('users');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addTask(Map<String, dynamic> param) async {
    try {
      var response = await _obj.postData('users', param);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
