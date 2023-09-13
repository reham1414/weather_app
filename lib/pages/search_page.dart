// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubits/weather_cubit/weather_cubit.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a City'),
        // backgroundColor: Colors.deepOrange,
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:  TextField(
            onChanged: (data){
              cityName=data;
            },
            onSubmitted: (data) async{
              cityName=data;
             BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!) ;
              BlocProvider.of<WeatherCubit>(context,listen: false).cityName=cityName;
             Navigator.pop(context);
            },
            decoration:  InputDecoration(
                hintText: 'Enter a City',
                border: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                    onTap : ()
                    {
                      // WeatherServices service = WeatherServices();
                      BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!) ;
                      BlocProvider.of<WeatherCubit>(context , listen: false).cityName =cityName;
                      //  service.getWeather(cityName: cityName!);
                      // BlocProvider.of<WeatherCubit>(context,listen: false).weatherModel  ;
                      // BlocProvider.of<WeatherCubit>(context,listen: false).cityName = cityName;
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.search)
                ),
              //   suffixIcon: IconButton(
              //       onPressed: () async
              //       {
              //         WeatherServices services=WeatherServices();
              //         WeatherModel weatherModel= await services.getWeather(cityName: cityName!);
              //         Provider.of<WeatherProvider>( context,listen: false).weatherData =weatherModel;
              //         Provider.of<WeatherProvider>(context,listen: false).cityName=cityName;
              //         Navigator.pop(context);
              //       },
              // icon:  const Icon(Icons.search),),
                label: const Text("Search"),
                contentPadding: const EdgeInsets.symmetric(vertical: 32 , horizontal: 24)
            ),
          ),
        ),
      ),

    );
  }
}
