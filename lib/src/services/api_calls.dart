import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cooky/cooky.dart' as cookie;
import 'package:scav/src/utils/variables.dart';

class ApiCalls {
  late Response response;
  late Response responseLogin;
  Dio dio = Dio();

  Future<bool> addUser(data, BuildContext context) async {
    response = await dio.post('${GlobalVariable.baseUrlApi}scav/v1/user/create',
        data: data);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addUserC(data, BuildContext context) async {
    response = await dio.post('${GlobalVariable.baseUrlApi}scav/v1/user/create',
        data: data);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(data, id, BuildContext context) async {
    response = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/user/update/$id',
        data: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePassUser(data, id, BuildContext context) async {
    response = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/user/updatePass/$id',
        data: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateDataAdFree(
      descripcion, telefono, ubicacion, BuildContext context) async {
    var idsend = cookie.get('id');
    FormData formData = FormData.fromMap({
      "descripcion": descripcion,
      "telefono": telefono,
      "ubicacion": ubicacion,
      "id": idsend
    });

    response = await dio.post(
        '${GlobalVariable.baseUrlApi}api/public/v1/free/update',
        data: formData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
