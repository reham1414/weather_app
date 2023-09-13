// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/services/weather_services.dart';
void main() {
  runApp( BlocProvider(
      create: (context) {
        return WeatherCubit(WeatherServices());
      },
      child: const WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(

    // Colors.blue : BlocProvider.of<WeatherCubit>(context).weatherModel!.getThemeColor(),),
    //   primarySwatch: BlocProvider.of<WeatherCubit>(context).weatherModel==null ?
    //   Colors.blue : BlocProvider.of<WeatherCubit>(context).weatherModel!.getThemeColor(),
        ),
          debugShowCheckedModeBanner: false,
          home:  HomePage(),
    );
  }
}