import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../response/app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices{

  @override
  Future<dynamic> getApi(String url)async{
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw InternetException('');
    }on RequestTimeOut{
      throw RequestTimeOut('');
    }

    return responseJson;

  }

  @override
  Future<dynamic> postApi(var data)async{
    dynamic responseJson;
    try{
      final response = await http.post(Uri.parse(""),

          body: jsonEncode(data)

      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw InternetException('');
    }on RequestTimeOut{
      throw RequestTimeOut('');
    }

    return responseJson;

  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException('Error accoured while communication with server '+response.statusCode.toString());
    }
  }
}