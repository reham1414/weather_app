 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubits/weather_cubit/weather_states.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_services.dart';
import 'package:flutter/material.dart';

class WeatherCubit extends Cubit<WeatherState>{
  WeatherCubit(this.weatherServices) : super(WeatherInitial());
  WeatherServices weatherServices;
  WeatherModel? weatherModel;
Color? primary;
String? cityName;
  void getWeather({required String cityName}) async{
    emit(WeatherLoading());

    try {
      weatherModel = await weatherServices.getWeather(cityName: cityName);
      primary = weatherModel!.getThemeColor();
      emit(WeatherSuccess());
    }  catch (e) {
      emit(WeatherFailure());
    }
  }
}