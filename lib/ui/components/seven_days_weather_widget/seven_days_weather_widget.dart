import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';
import 'package:weather_app_final/ui/ui_theme/app_syle.dart';

class SevenDaysWeatherWidget extends StatelessWidget {
  const SevenDaysWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.sevenDayBoxColor,
      ),
      height: 350,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SevenDaysWidget(
            text: model.date[index],
            daylyIcon: model.setDailyIcons(index),
            dayTemp: model.setDailyTemp(index),
            nightTemp: model.setNightTemp(index),
          );
        },
        itemCount: model.date.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
    );
  }
}

class SevenDaysWidget extends StatelessWidget {
  const SevenDaysWidget({
    super.key,
    required this.text,
    required this.daylyIcon,
    this.dayTemp = 0,
    this.nightTemp = 0,
  });
  final String text;
  final String daylyIcon;
  final int dayTemp;
  final int nightTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            text,
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ),
        const SizedBox(width: 30),
        Image.network(
          daylyIcon,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 20),
        Text(
          '$dayTemp °C',
          style: AppStyle.fontStyle,
        ),
        const SizedBox(width: 10),
        Text(
          '$nightTemp °C',
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.nightTempColor,
          ),
        ),
      ],
    );
  }
}
