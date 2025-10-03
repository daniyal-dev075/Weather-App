import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'BaseApiServices.dart';


class NetworkApiServices extends BaseApiServices{
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
  @override
  Future postApiResponse(String url, data) async {
    dynamic responseJson;
    try{
      final response = await http.post(Uri.parse(url), headers: {
        'x-api-key': 'reqres-free-v1',
      },body: data).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
  }
dynamic returnResponse(http.Response response){
  switch(response.statusCode){
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 404:
      throw UnAuthorizedException(response.body.toString());
    default:
      throw FetchDataException('Error! ${response.statusCode}');
  }
}