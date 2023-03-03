import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';
import 'package:weather_app_final/ui/ui_theme/app_syle.dart';

class CurrentRegionItem extends StatelessWidget {
  const CurrentRegionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage(
              model.setBg(),
            ),
            fit: BoxFit.cover,
          ),
        ),
        width: 382,
        height: 96,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CurrentRegionTimeZone(
              currentCity: model.weatherData?.timezone,
              currentZone: model.weatherData?.timezone,
            ),
            CurrentRegionTemp(
              icon: model.iconData(),
              currentTemp: model.setCurrentTemp(),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentRegionTimeZone extends StatelessWidget {
  const CurrentRegionTimeZone({
    super.key,
    required this.currentCity,
    required this.currentZone,
  });
  final String? currentCity;
  final String? currentZone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Текущее место',
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.blackColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          currentZone ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          currentCity ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 14,
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}

class CurrentRegionTemp extends StatelessWidget {
  const CurrentRegionTemp(
      {super.key, required this.icon, required this.currentTemp});
  final String icon;
  final int currentTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(icon),
        Text(
          '$currentTemp °C',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}
