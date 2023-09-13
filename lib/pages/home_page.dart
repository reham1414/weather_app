// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather/cubits/weather_cubit/weather_states.dart';
import 'package:weather/pages/search_page.dart';
import 'package:weather/models/weather_model.dart';
class HomePage extends StatelessWidget{
   WeatherModel? weatherData;
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlocProvider.of<WeatherCubit>(context).weatherModel==null ?
        Colors.blue : BlocProvider.of<WeatherCubit>(context).primary,
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return  SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    body: BlocBuilder<WeatherCubit  , WeatherState>(
      builder: (context , state){
        if(state is WeatherLoading){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(state is WeatherSuccess){
          weatherData= BlocProvider.of<WeatherCubit>(context).weatherModel;
          return  WeatherSuccessScreen(weatherData: weatherData);
        }
        else if(state is WeatherFailure){
          return const Center(child: Text('Something went wrong,try again'),);
        }
        else{
          return const DefaultScreen() ;
        }
      },
    ),
    );
  }
}

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'there is no weather 😔 start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  'searching now 🔍',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ],
            ),
          );
  }
}

class WeatherSuccessScreen extends StatelessWidget {
  const WeatherSuccessScreen({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                weatherData!.getThemeColor(),
                weatherData!.getThemeColor()[300]!,
                weatherData!.getThemeColor()[100]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child :  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3,),
               Text(
                BlocProvider.of<WeatherCubit>(context).cityName!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              ),
               Text(
                'Updated at : ${weatherData!.date.hour.toString()} : ${weatherData!.date.minute.toString()}',
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(weatherData!.getImage()),
                   Text(
                    weatherData!.temp.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Column(
                    children: [
                      Text(
                      'maxTemp :${weatherData!.maxtemp.toInt()}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'minTemp : ${weatherData!.mintemp.toInt()}',
                        style: const TextStyle(
                          fontSize: 18,

                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
               Text(
                weatherData?.weatherStateName?? '',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 5,),
            ],
          ),
      );
  }
}


