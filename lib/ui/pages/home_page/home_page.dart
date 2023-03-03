

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/components/current_weather_status/current_weather_status.dart';
import 'package:weather_app_final/ui/components/max_min_temp/max_min_temp.dart';
import 'package:weather_app_final/ui/components/seven_days_weather_widget/seven_days_weather_widget.dart';
import 'package:weather_app_final/ui/components/sunrize_sunset_widget/sunrize_sunset_widget.dart';
import 'package:weather_app_final/ui/components/weather_appbar/weather_appbar.dart';
import 'package:weather_app_final/ui/components/weather_grid_item_widget/weather_grid_item_widget.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';
import 'package:weather_app_final/ui/ui_theme/app_syle.dart';

class HomePage extends StatelessWidget {
   HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<WeatherProvider>(context).setUp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const HomePageWidget();
            case ConnectionState.waiting:
            default:
              return Container(
                decoration:  BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              model.setBg(),
                ),),),);
          }
        },
      ),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            model.setBg(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const WeatherAppBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 10,
              ),
              children: [
                Text(
                  '${model.date.last} ${model.currentTime}',
                  textAlign: TextAlign.center,
                  style: AppStyle.fontStyle.copyWith(
                    color: AppColors.darkBlueColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 36),
                const CurrentWeatherStatus(),
                const SizedBox(height: 28),
                Text(
                  '${model.currentTemp}°C',
                  textAlign: TextAlign.center,
                  style: AppStyle.fontStyle.copyWith(
                    fontSize: 90,
                    color: AppColors.darkBlueColor,
                  ),
                ),
                const SizedBox(height: 18),
                const MaxMinTemp(),
                const SizedBox(height: 40),
                const SevenDaysWeatherWidget(),
                const SizedBox(height: 28),
                const SizedBox(
                  height: 382,
                  child: WeatherGridItemWidget(),
                ),
                const SizedBox(height: 30),
                const SunrizeSunsetWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
