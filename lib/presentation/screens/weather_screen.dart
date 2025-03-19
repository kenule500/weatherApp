import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import '../widgets/additional_info_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<WeatherBloc>().add(WeatherFetched());
              },
            ),
          ],
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherFailure) {
              return Center(child: Text(state.error));
            }
            if (state is! WeatherSuccess) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final data = state.weatherModel;

            final currentTemp = data.currentTemp;
            final currentSky = data.currentSky;
            final currentPressure = data.currentPressure;
            final currentWindSpeed = data.currentWindSpeed;
            final currentHumidity = data.currentHumidity;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              spacing: 16,
                              children: [
                                Text(
                                  '$currentTemp k',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                    currentSky == 'Clouds' ||
                                            currentSky == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 70),
                                Text(currentSky,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Hourly Forecast",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //     height: 120,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: 9,
                  //       itemBuilder: (context, index) {
                  //         final hourlySky = data.currentSky;
                  //         final time = DateTime.parse(hourlyForecast['dt_txt']);
                  //         return HourlyForecastItem(
                  //             time: DateFormat.Hm().format(time),
                  //             icon:
                  //                 hourlySky == 'Clouds' || hourlySky == 'Clear'
                  //                     ? Icons.cloud
                  //                     : Icons.sunny,
                  //             temperature:
                  //                 hourlyForecast['main']['temp'].toString());
                  //       },
                  //     ))

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       for (int i = 1; i < 5; i++)
                  //         HourlyForecastItem(
                  //             time: data['list'][i]['dt_txt'].toString(),
                  //             icon: data['list'][i]['weather'][0]['main'] ==
                  //                         'Clouds' ||
                  //                     data['list'][i]['weather'][0]['main'] ==
                  //                         'Clear'
                  //                 ? Icons.cloud
                  //                 : Icons.sunny,
                  //             temperature:
                  //                 data['list'][i]['main']['temp'].toString()),
                  //     ],
                  //   ),
                  // ),
                  // ,
                  const Text("Additional Information",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: currentHumidity.toString()),
                      AdditionalInfoItem(
                          icon: Icons.air,
                          label: 'Wind Speed',
                          value: currentWindSpeed.toString()),
                      AdditionalInfoItem(
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          value: currentPressure.toString()),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
