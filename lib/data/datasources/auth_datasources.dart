import 'dart:convert';

import 'package:fic4_flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/login_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/register_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/login_response_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/profile_response_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthDatasource {
  Future<RegisterResponseModel> register(RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/users/'),
      // headers: {'Content-Type': 'application/json'},
      body: registerModel.toMap(),
    );

    // final result = RegisterResponseModel.jsondecode(response.body);
    final result = RegisterResponseModel.fromJson(jsonDecode(response.body));
    return result;
  }

  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
      // headers: {'Content-Type': 'application/json'},
      body: loginModel.toMap(),
    );

    // final result = RegisterResponseModel.jsondecode(response.body);
    final result = LoginResponseModel.fromJson((response.body));
    return result;
  }

  Future<ProfileResponseModel> getProfil() async {
    final token = await AuthLocalStorage().getToken();
    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
      headers: headers,
    );

    // final result = RegisterResponseModel.jsondecode(response.body);
    final result = ProfileResponseModel.fromJson(jsonDecode(response.body));
    return result;
  }
}
