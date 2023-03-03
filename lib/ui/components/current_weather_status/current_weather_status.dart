import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';
import 'package:weather_app_final/ui/ui_theme/app_syle.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          model.iconData(),
          scale: 1.1,
          width: 50,
          color: AppColors.weatherStatusIconColor,
        ),
        const SizedBox(width: 25),
        Text(
          ' ${model.getCurrentStatus()}',
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.darkBlueColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
