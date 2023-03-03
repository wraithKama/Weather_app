import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';
import 'package:weather_app_final/ui/ui_theme/app_syle.dart';

class WeatherGridItemWidget extends StatelessWidget {
  const WeatherGridItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();

    return GridView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 181,
          height: 181,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: AppColors.gridBoxColor,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 57, horizontal: 20),
              leading: SvgPicture.asset(
                WeatherGridIcons.weatherGridIcons[index],
                color: AppColors.iconsColor,
              ),
              title: Text(
                '${model.setValues(index)} ${WeatherGridUnits.weatherGridUnits[index]}',
                style: AppStyle.fontStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                WeatherGridDescription.gridItemDescription[index],
                style: AppStyle.fontStyle.copyWith(
                  fontSize: 10,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}

class WeatherGridIcons {
  static List<String> weatherGridIcons = [
    'assets/icons/wind_speed.svg',
    'assets/icons/feels_like.svg',
    'assets/icons/raindrops.svg',
    'assets/icons/visibility.svg',
  ];
}

class WeatherGridDescription {
  static List<String> gridItemDescription = [
    'Скорость ветра',
    'Ощущается',
    'Влажность',
    'Видимость',
  ];
}

class WeatherGridUnits {
  static List<String> weatherGridUnits = [
    'км/ч',
    '°',
    '%',
    'км',
  ];
}
