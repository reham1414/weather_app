// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_model.dart';

class  WeatherServices{

  String baseUrl= 'http://api.weatherapi.com/v1';

  String apiKey= '345eae5ef59e47f183d02305232707';

  Future<WeatherModel> getWeather({required String cityName}) async{

    Uri url=
        Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');

    http.Response response = await http.get(url);
    if (response.statusCode == 400) {
      var data  = jsonDecode(response.body);
      throw Exception(data['error']['message']);
    }

    Map<String , dynamic> data = jsonDecode(response.body);

    WeatherModel currentWeather= WeatherModel.fromJson(data);

    return currentWeather;

  }

}