import 'dart:convert';

import 'package:fic4_flutter_auth_bloc/data/models/request/register_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class ApiDatasource {
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
}
