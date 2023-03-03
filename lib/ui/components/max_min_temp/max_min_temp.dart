import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';
import 'package:weather_app_final/ui/ui_theme/app_syle.dart';

class MaxMinTemp extends StatelessWidget {
  const MaxMinTemp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/max_temp_icon.svg',
          color: AppColors.redColor,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '${model.setMaxTemp()}°C',
          style: AppStyle.fontStyle.copyWith(fontSize: 25),
        ),
        const SizedBox(
          width: 65,
        ),
        SvgPicture.asset(
          'assets/icons/min_temp_icon.svg',
          color: AppColors.blueColor,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '${model.setMinTemp()} °C',
          style: AppStyle.fontStyle,
        ),
      ],
    );
  }
}
